$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'sinatra'
require 'sinatra/activerecord'
require 'boxes_monitor'

get '/' do
  'Hello World'
end
