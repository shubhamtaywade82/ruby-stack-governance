# frozen_string_literal: true

require_relative "../../lib/ruby_stack_governance/corpus"
require_relative "../../lib/ruby_stack_governance/agent_mirror"

RSpec.describe RubyStackGovernance::AgentMirror do
  it "is idempotent and byte-stable (Law 6)" do
    first = described_class.render_all
    expect(described_class.render_all).to eq(first)
  end

  it "mirrors every artifact flagged mirror: true" do
    mirrored = RubyStackGovernance::Corpus.manifest.count { |a| a["mirror"] }
    skills = described_class.render_all.count { |path, _body| path.end_with?("SKILL.md") }
    expect(skills).to eq(mirrored)
  end

  it "keeps a digest in every mirrored artifact" do
    RubyStackGovernance::Corpus.manifest.select { |a| a["mirror"] }.each do |a|
      path = File.join(RubyStackGovernance::Corpus::ROOT, a["file"])
      expect(File.read(path)).to match(/^## Agent Digest$/)
    end
  end
end
