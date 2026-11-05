# frozen_string_literal: true

require 'yaml'
require 'ruby_stack_governance/mcp/tools'

RSpec.describe RubyStackGovernance::MCP::Tools do
  it 'pins the wire contract' do
    snapshot = YAML.safe_load_file(File.expand_path('contract_snapshot.yml', __dir__), aliases: true)
    expect(described_class.wire_schemas).to eq(snapshot)
  end

  it 'exposes the nine v1.0.0 tools in registry order' do
    expected = %w[list_artifacts get_artifact search_corpus get_limit get_ratchet
                  get_versions get_todo_baseline resolve_violation run_gate]
    expect(described_class.wire_schemas.map { |tool| tool['name'] }).to eq(expected)
  end

  it 'is read-only — no tool name starts with create, update, delete, or write' do
    forbidden = /\A(create|update|delete|write)/
    names = described_class.wire_schemas.map { |tool| tool['name'] }
    expect(names).not_to include(a_string_matching(forbidden))
  end
end
