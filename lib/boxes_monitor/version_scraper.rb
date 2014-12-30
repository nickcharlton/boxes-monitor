require 'active_support/core_ext/string'

require 'boxes_monitor/strategies/base'

module BoxesMonitor
  class VersionScraper
    def self.run(type, version)
      begin
        require "boxes_monitor/strategies/#{type}"
      rescue LoadError
        $stderr.puts "No scraping strategy known as #{type}"
      end

      strategy = "boxes_monitor/strategies/#{type}".camelize.constantize
      strategy_instance = strategy.new
      strategy_instance.run(version)
    end
  end
end
