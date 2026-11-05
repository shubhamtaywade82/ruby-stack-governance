# frozen_string_literal: true

require "yaml"

module RubyStackGovernance
  # Routes a metric name to the single file that owns its limit (Law 3). The
  # routing table is code (versioned); the VALUES are always read live from
  # the owning file at call time — never embedded here.
  class LimitRoutes
    ROUTES = {
      "rubocop_metrics_class_length" => { "file" => ".rubocop.yml", "path" => %w[Metrics ClassLength Max] },
      "rubocop_metrics_method_length" => { "file" => ".rubocop.yml", "path" => %w[Metrics MethodLength Max] },
      "rubocop_metrics_abc_size" => { "file" => ".rubocop.yml", "path" => %w[Metrics AbcSize Max] },
      "rubocop_layout_line_length" => { "file" => ".rubocop.yml", "path" => %w[Layout LineLength Max] },
      "rubocop_rspec_example_length" => { "file" => ".rubocop.yml", "path" => %w[RSpec ExampleLength Max] },
      "ruby_version" => { "file" => ".ruby-version", "path" => [] }
    }.freeze

    # Reads the live value and returns it annotated with its source pointer.
    def self.limit(metric)
      route = ROUTES[metric]
      return { "error" => "unknown metric", "known" => ROUTES.keys } if route.nil?

      full = File.join(Corpus::ROOT, route["file"])
      value = route["path"].empty? ? File.read(full).strip : route["path"].reduce(config(full)) { |acc, key| acc&.[](key) }
      { "metric" => metric, "value" => value, "source" => route["file"],
        "source_path" => route["path"].join("/") }
    end

    # Implementation detail: load the owning YAML file.
    def self.config(path)
      YAML.safe_load(File.read(path), aliases: true)
    end
  end
end
