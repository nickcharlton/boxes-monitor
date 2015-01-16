$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'sinatra'
require 'sinatra/activerecord'
require 'boxes_monitor'

%w(tool version).each do |model|
  require File.expand_path "models/#{model}.rb", __dir__
end

get '/' do
  @title = 'Boxes Monitor'
  @tools = Tool.all

  erb :home
end

get '/tools/:id' do
  @tool = Tool.find(params[:id])
  @title = "#{@tool.name} – Boxes Monitor"

  erb :tool
end
