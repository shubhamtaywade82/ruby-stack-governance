# frozen_string_literal: true

require 'ruby_stack_governance/agent_mirror'

desc 'Regenerate agent-facing mirrors (idempotent, byte-stable)'
task 'agent:mirror' do
  RubyStackGovernance::AgentMirror.generate!
end

desc 'Drift gate — fail when mirrors are stale (Law 5)'
task 'agent:mirror:check' do
  Rake::Task['agent:mirror'].invoke
  dirty = `git status --porcelain -- .claude/skills .cursor/rules AGENT_CONTEXT.md .cursorrules`.strip
  abort('AGENT MIRROR DRIFT — run `bin/rake agent:mirror` and commit the result') unless dirty.empty?
end
