# frozen_string_literal: true

require "fast_mcp"
require "open3"

module RubyStackGovernance
  module MCP
    # The nine read-only tools of the agent contract (v1.0.0, tools-only — D7,
    # R9). Wire schemas are pinned by spec/mcp/contract_snapshot.yml: changing
    # one requires bumping MCP::VERSION and a CHANGELOG entry (D9).
    module Tools
      # Builds one pinned wire-schema entry: name, description, arguments.
      def self.schema_for(name, description, arguments)
        { "name" => name, "description" => description,
          "arguments" => arguments.map { |a| { "name" => a[0], "type" => a[1], "required" => a[2] } } }
      end

      # Lists every governance artifact; optional stack filter.
      class ListArtifacts < FastMcp::Tool
        DESCRIPTION = "List governance artifacts (standards knowledge base); optional stack filter"

        tool_name "list_artifacts"
        description DESCRIPTION

        arguments do
          optional(:stack).maybe(:string, included_in?: %w[ruby rails react all])
        end

        def call(stack: "all")
          Corpus.manifest.filter_map do |a|
            next unless stack == "all" || Array(a["stacks"]).include?(stack)

            { "id" => a["id"], "title" => a["title"], "stacks" => a["stacks"],
              "layer" => a["layer"], "file" => a["file"] }
          end
        end

        def self.wire_schema
          Tools.schema_for("list_artifacts", DESCRIPTION, [["stack", "string", false]])
        end
      end

      # Returns one artifact: manifest metadata plus full body.
      class GetArtifact < FastMcp::Tool
        DESCRIPTION = "Return one artifact's full body plus manifest metadata"

        tool_name "get_artifact"
        description DESCRIPTION

        arguments do
          required(:id).filled(:string)
        end

        def call(id:)
          Corpus.artifact(id)
        rescue KeyError => e
          { "error" => e.message }
        end

        def self.wire_schema
          Tools.schema_for("get_artifact", DESCRIPTION, [["id", "string", true]])
        end
      end

      # Case-insensitive search over docs/artifacts.
      class SearchCorpus < FastMcp::Tool
        DESCRIPTION = "Search artifacts (case-insensitive); returns artifact id, file, line, text"

        tool_name "search_corpus"
        description DESCRIPTION

        arguments do
          required(:query).filled(:string)
          optional(:stack).maybe(:string, included_in?: %w[ruby rails react])
        end

        def call(query:, stack: nil)
          Corpus.search(query, stack: stack)
        end

        def self.wire_schema
          Tools.schema_for("search_corpus", DESCRIPTION, [["query", "string", true], ["stack", "string", false]])
        end
      end

      # Reads one limit live from its single source file (Law 3).
      class GetLimit < FastMcp::Tool
        DESCRIPTION = "Current limit for a metric, read live from its single source file"

        tool_name "get_limit"
        description DESCRIPTION

        arguments do
          required(:metric).filled(:string)
        end

        def call(metric:)
          LimitRoutes.limit(metric)
        end

        def self.wire_schema
          Tools.schema_for("get_limit", DESCRIPTION, [["metric", "string", true]])
        end
      end

      # Reads one ratchet entry from docs/ratchets.yml (single home).
      class GetRatchet < FastMcp::Tool
        DESCRIPTION = "Current and next ratchet target for a metric from docs/ratchets.yml"

        tool_name "get_ratchet"
        description DESCRIPTION

        arguments do
          required(:metric).filled(:string)
        end

        def call(metric:)
          Corpus.ratchet(metric)
        end

        def self.wire_schema
          Tools.schema_for("get_ratchet", DESCRIPTION, [["metric", "string", true]])
        end
      end

      # Version pins, each annotated with its owning file.
      class GetVersions < FastMcp::Tool
        DESCRIPTION = "Version pins, each annotated with the single file that owns it"

        tool_name "get_versions"
        description DESCRIPTION

        arguments do
        end

        def call(**_kwargs)
          Corpus.versions
        end

        def self.wire_schema
          Tools.schema_for("get_versions", DESCRIPTION, [])
        end
      end

      # Current todo baseline for the one-way ratchet (Law 2).
      class GetTodoBaseline < FastMcp::Tool
        DESCRIPTION = "Current todo baseline — cops, excluded files, and value overrides"

        tool_name "get_todo_baseline"
        description DESCRIPTION

        arguments do
        end

        def call(**_kwargs)
          Corpus.todo_baseline
        end

        def self.wire_schema
          Tools.schema_for("get_todo_baseline", DESCRIPTION, [])
        end
      end

      # Resolves a RuboCop offense against the corpus.
      class ResolveViolation < FastMcp::Tool
        DESCRIPTION = "For a RuboCop cop — configured state, todo status, artifact hits"

        tool_name "resolve_violation"
        description DESCRIPTION

        arguments do
          required(:cop_name).filled(:string)
          optional(:snippet).maybe(:string)
        end

        def call(cop_name:, snippet: nil)
          { "cop" => cop_name,
            "configured" => Corpus.cop_configured?(cop_name),
            "in_todo_baseline" => Corpus.todo_baseline["cops"].any? { |c| c["cop"] == cop_name },
            "artifact_hits" => Corpus.search(cop_name),
            "snippet" => snippet }
        end

        def self.wire_schema
          Tools.schema_for("resolve_violation", DESCRIPTION, [["cop_name", "string", true], ["snippet", "string", false]])
        end
      end

      # Runs an allowlisted gate by registry name (D4): array argv, no shell.
      class RunGate < FastMcp::Tool
        DESCRIPTION = "Run a named enforcement gate from the allowlisted registry (config/gates.yml)"

        tool_name "run_gate"
        description DESCRIPTION

        arguments do
          required(:gate).filled(:string)
        end

        def call(gate:)
          found = Gates.command_for(gate)
          return { "error" => "unknown gate", "known" => Gates.names } if found.nil?

          started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
          out, status = Open3.capture2e(*found["argv"], chdir: Corpus::ROOT)
          { "gate" => gate, "context" => found["context"], "exit_status" => status.exitstatus,
            "duration_ms" => ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - started) * 1000).round,
            "output_tail" => out.lines.last(40).join }
        end

        def self.wire_schema
          Tools.schema_for("run_gate", DESCRIPTION, [["gate", "string", true]])
        end
      end

      # Registry order is pinned by the contract snapshot.
      ALL = [ListArtifacts, GetArtifact, SearchCorpus, GetLimit, GetRatchet,
             GetVersions, GetTodoBaseline, ResolveViolation, RunGate].freeze

      # The pinned wire contract — spec/mcp/contract_snapshot.yml must equal this.
      def self.wire_schemas
        ALL.map(&:wire_schema)
      end
    end
  end
end
