require 'boxes_monitor/version'
require 'boxes_monitor/version_scraper.rb'

module BoxesMonitor
  def self.dependencies
    YAML.load_file File.expand_path('../../dependencies.yml', __FILE__)
  end
end
