##
# Initialise Bundler, catch errors.
##
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems.'
  exit e.status_code
end

##
# Pull in the application
##
require 'sinatra/activerecord/rake'
require './app'

namespace :app do
  desc 'Run the dependency update cycle.'
  task :update_dependencies do
    # update every version
    BoxesMonitor.dependencies.each do |k, v|
      v.each do |ea|
        current_version = BoxesMonitor::VersionScraper.run(k.to_sym, ea)

        # build up the tool name, with a special case for GitHub repos
        if k == 'github'
          tool_name = "#{ea}"
        else
          tool_name = "#{k.capitalize} #{ea.capitalize}"
        end

        tool = Tool.find_or_initialize_by name: tool_name
        puts "Added new tool: #{tool_name}" if tool.new_record?
        tool.save!

        existing = tool.versions.find_by_version current_version[:version]
        unless existing
          version = Version.new Hash[tool: tool].merge current_version
          version.save!

          puts "Added new version: #{tool.name} #{current_version[:version]}"
        end
      end
    end

    # run the notifications
  end
end

##
# Configure the test suite.
##
require 'rake/testtask'

Rake::TestTask.new :spec do |t|
  t.test_files = Dir['spec/**/*_spec.rb']
end

##
# By default, just run the tests.
##
task default: :spec
