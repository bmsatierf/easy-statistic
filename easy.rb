#encoding: utf-8

require File.expand_path('statistic.rb')
require 'rubygems'
require 'sinatra'
require 'sinatra/partial'

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
    @statistic.process_data(params["raw"]["distribution_type"])
    @table = @statistic.table
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
end

class Array
  def to_sentence
    words_connector = ", "
    two_words_connector = " e "

    case length
      when 0
        ""
      when 1
        self[0].to_s
      when 2
        "#{self[0]}#{two_words_connector}#{self[1]}"
      else
        "#{self[0...-1].join(words_connector)}#{two_words_connector}#{self[-1]}"
    end
  end
end