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

##
# Pull in any additional tasks
##
Dir['tasks/**/*.rake'].each { |task| import task }

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
