# frozen_string_literal: true

require 'yaml'

module RubyStackGovernance
  # Allowlisted execution surface for the MCP `run_gate` tool (R9/D4): registry
  # names only, array-form argv, never a shell, never argument interpolation.
  # The registry file config/gates.yml is the single home for gate commands.
  class Gates
    REGISTRY_PATH = File.expand_path('../../config/gates.yml', __dir__)

    # Full registry: {"self" => {...}, "app" => {...}}.
    def self.registry
      YAML.safe_load_file(REGISTRY_PATH, aliases: true)
    end

    # Resolves a gate name to {context, argv} — self scope wins over app scope.
    # Returns nil for unknown names; nothing outside the registry executes.
    def self.command_for(name)
      %w[self app].each do |context|
        argv = registry.fetch(context, {})[name.to_s]
        return { 'context' => context, 'argv' => argv } if argv
      end
      nil
    end

    # Sorted, deduplicated gate names across both contexts.
    def self.names
      registry.values.flat_map(&:keys).uniq.sort
    end
  end
end
