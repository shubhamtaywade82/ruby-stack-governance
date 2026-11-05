# frozen_string_literal: true

require 'fast_mcp'
require_relative 'corpus'
require_relative 'gates'
require_relative 'limit_routes'
require_relative 'mcp/tools'

module RubyStackGovernance
  module MCP
    # Agent contract version (single home). A contract change without a version
    # bump fails the mcp_contract gate (spec/mcp/contract_snapshot.yml, D9).
    VERSION = '1.0.0'

    # Assembles the stdio server (D1, R9): read-only tools only (D3).
    module Server
      def self.run
        server = FastMcp::Server.new(name: 'ruby-stack-governance', version: VERSION)
        Tools::ALL.each { |tool| server.register_tool(tool) }
        server.start
      end
    end
  end
end
