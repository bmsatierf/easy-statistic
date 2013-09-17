#encoding: utf-8

require File.expand_path('statistic.rb')
require 'rubygems'
require 'sinatra'
require 'sinatra/partial'
require 'sinatra/content_for'
require 'sinatra/reloader' if development?

set :partial_template_engine, :erb
set :views, File.dirname(__FILE__) + '/templates'

get '/' do
  erb :index
end

post '/' do
  @raw_data = params["raw"]["data"]

  if @raw_data.empty? || @raw_data.nil?
    @error = 'É necessário informar os dados a serem processados, separados por vírgula.'
  else
    @statistic = Statistic.new(@raw_data)
    @statistic.process_data(params["distribution_type"], params["collection_type"])
    @table = @statistic.table
    @chart = @statistic.chart
  end

  erb :index
end

get '/about' do
  erb :about
end

helpers do
  def is_active?(page)
    return "active" if page == request.path
    return ""
  end

  def is_checked?(option)
    return "checked" if option == params["collection_type"] || option == "population" && params["collection_type"].nil?
    return ""
  end
end