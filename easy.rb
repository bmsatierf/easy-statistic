require File.expand_path('statistic.rb')
require 'rubygems'
require 'sinatra'
require 'sinatra/partial'
require 'sinatra/content_for'
require 'sinatra/reloader' if development?
require 'json'

set :partial_template_engine, :erb
set :views, File.dirname(__FILE__) + '/templates'

get '/' do
  erb :index
end

get '/about' do
  erb :about
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

get '/normal-distribution' do
  content_type :json

  statistic = Statistic.new

  probability = statistic.normal_distribution(
                  params["type"],
                  params["mean"].to_f,
                  params["standard-deviation"].to_f,
                  params["less"],
                  params["greater"])

  { :probability => probability }.to_json
end

get '*' do
  redirect '/', 301
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

  def distribution(type)
    type == "discrete" ? "discreta" : "contínua"
  end
end
