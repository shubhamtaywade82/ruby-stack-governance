# frozen_string_literal: true

require "open3"
require "yaml"

module RubyStackGovernance
  # Read-only access to the governance corpus. Every method returns data that
  # was READ from its single home — this class never embeds limits or copies
  # (Law 3). Write access does not exist here: the process layer (PR + gates)
  # is the only write path (D3).
  class Corpus
    ROOT = File.expand_path("../..", __dir__)
    MANIFEST_PATH = File.join(ROOT, "docs/artifacts/MANIFEST.yml")
    RATCHETS_PATH = File.join(ROOT, "docs/ratchets.yml")
    ARTIFACTS_DIR = File.join(ROOT, "docs/artifacts")

    # Manifest entries (id, title, stacks, layer, file, mirror fields).
    def self.manifest
      YAML.safe_load(File.read(MANIFEST_PATH), aliases: true)["artifacts"]
    end

    # One artifact: manifest metadata plus the full body read from its file.
    def self.artifact(id)
      entry = manifest.find { |a| a["id"] == id }
      raise KeyError, "unknown artifact: #{id}" if entry.nil?

      { "id" => entry["id"], "title" => entry["title"], "stacks" => entry["stacks"],
        "layer" => entry["layer"], "file" => entry["file"],
        "body" => File.read(File.join(ROOT, entry["file"])) }
    end

    # Case-insensitive search over docs/artifacts. Prefers ripgrep, falls back
    # to grep when rg is unavailable. Results are capped for context economy.
    def self.search(query, stack: nil)
      raw = search_files(query).filter_map do |file, line, text|
        entry = manifest.find { |a| a["file"] == file }
        next if entry.nil?
        next if stack && !Array(entry["stacks"]).include?(stack)

        { "artifact" => entry["id"], "file" => file, "line" => line.to_i, "text" => text }
      end
      raw.first(25)
    end

    # Whether a RuboCop cop is configured in the live .rubocop.yml.
    def self.cop_configured?(cop)
      config = YAML.safe_load(File.read(File.join(ROOT, ".rubocop.yml")), aliases: true)
      node = cop.split("/").reduce(config) { |acc, part| acc.is_a?(Hash) ? acc[part] : nil }
      node.is_a?(Hash)
    end

    # One ratchet entry, read from docs/ratchets.yml (single home).
    def self.ratchet(metric)
      entry = all_ratchets.find { |r| r["metric"] == metric }
      return { "error" => "unknown metric", "known" => all_ratchets.map { |r| r["metric"] } } if entry.nil?

      entry
    end

    def self.all_ratchets
      YAML.safe_load(File.read(RATCHETS_PATH), aliases: true)
    end

    # Current todo baseline: cops with excludes or value overrides.
    def self.todo_baseline
      parsed = YAML.safe_load(File.read(File.join(ROOT, ".rubocop_todo.yml")), aliases: true) || {}
      cops = parsed.filter_map do |cop, conf|
        next unless conf.is_a?(Hash) && cop != "AllCops"

        { "cop" => cop, "excluded_files" => Array(conf["Exclude"]).length,
          "overrides" => (conf.keys - ["Exclude"]).sort }
      end
      { "entries" => cops.length,
        "total_excluded_files" => cops.sum { |c| c["excluded_files"] },
        "cops" => cops }
    end

    # Version pins, each annotated with the single file that owns it.
    def self.versions
      {
        "ruby" => { "version" => File.read(File.join(ROOT, ".ruby-version")).strip,
                    "source" => ".ruby-version" },
        "rails" => { "target" => "~> 7.2 (target-app Gemfile.lock is the single home)",
                     "next_track" => "8.1 (adopted R7)", "source" => "target-app Gemfile.lock" },
        "rubocop" => { "constraint" => ">= 1.72", "syntax" => "plugins:",
                       "source" => "Gemfile + .rubocop.yml" },
        "gemfile_lock" => { "present" => File.exist?(File.join(ROOT, "Gemfile.lock")),
                            "source" => "Gemfile.lock (single home for gem pins)" }
      }
    end

    # Implementation detail of search: shell out with array argv, never a shell.
    def self.search_files(query)
      out, = Open3.capture2("rg", "-i", "-n", "--no-heading", "-m", "40", "-e", query, ARTIFACTS_DIR)
      parse_hits(out)
    rescue Errno::ENOENT
      out, = Open3.capture2("grep", "-rniE", "-m", "40", "--", query, ARTIFACTS_DIR)
      parse_hits(out)
    end

    def self.parse_hits(raw)
      raw.lines.filter_map do |line|
        file, line_no, text = line.strip.split(":", 3)
        next if text.nil?

        [file.delete_prefix("#{ROOT}/"), line_no, text]
      end
    end
  end
end
