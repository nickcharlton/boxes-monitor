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

        puts "current_version: #{current_version}"
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
