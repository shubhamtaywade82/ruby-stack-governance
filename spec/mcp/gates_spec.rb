# frozen_string_literal: true

require_relative "../../lib/ruby_stack_governance/gates"

RSpec.describe RubyStackGovernance::Gates do
  it "never resolves a command for a non-allowlisted gate" do
    expect(described_class.command_for("rm -rf /")).to be_nil
    expect(described_class.command_for("; bundle exec rubocop")).to be_nil
  end

  it "resolves self gates before app gates" do
    expect(described_class.command_for("agent_mirror")).to eq("context" => "self",
                                                              "argv" => %w[bin/rake agent:mirror:check])
  end

  it "lists gate names from both contexts" do
    expect(described_class.names).to include("rubocop", "brakeman")
  end
end
