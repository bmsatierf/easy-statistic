#encoding: utf-8

ENV['RACK_ENV'] = 'test'

require File.expand_path('easy.rb')
require 'test/unit'
require 'rack/test'

class EasyTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_get_index
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('Estatística')
  end

  def test_get_about
    get '/about'
    assert last_response.ok?
    assert last_response.body.include?('Estatística')
  end

  def test_setup_sorted_array
    stat = Statistic.new("3,1,5,6,2,4")
    assert_equal([1,2,3,4,5,6], stat.ranked_data)
  end

  def test_setup_uniq_count
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    assert_equal({5=>1, 1=>2, 2=>1, 3=>3, 4=>2}, stat.uniq_count)
  end

  def test_invalid_distribution_type
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("other")
    assert_equal("Invalid distribution type.", stat.table)
  end

  # DISCRETE TESTS
  def test_process_discrete_variable
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("discrete")
    assert_equal(
      {
        0=>{"xi"=>1, "fi"=>2, "fr%"=>22, "F"=>2, "F%"=>22,  "xi*fi"=>2},
        1=>{"xi"=>2, "fi"=>1, "fr%"=>11, "F"=>3, "F%"=>33,  "xi*fi"=>2},
        2=>{"xi"=>3, "fi"=>3, "fr%"=>33, "F"=>6, "F%"=>66,  "xi*fi"=>9},
        3=>{"xi"=>4, "fi"=>2, "fr%"=>22, "F"=>8, "F%"=>88,  "xi*fi"=>8},
        4=>{"xi"=>5, "fi"=>1, "fr%"=>11, "F"=>9, "F%"=>100, "xi*fi"=>5}
      },
      stat.table
    )
  end

  def test_post_discrete_variable
    post '/?raw[data]=1,1,2,3,3,3,4,4,5&raw[distribution_type]=discrete'
    assert last_response.ok?
    assert last_response.body.include?('Processamento da variável quantitativa discreta')
  end

  def test_post_discrete_variable_without_data
    post '/?raw[data]=&raw[distribution_type]=discrete'
    assert last_response.ok?
    assert last_response.body.include?('É necessário informar os dados a serem processados, separados por vírgula.')
  end

  def test_discrete_mode
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("discrete")
    assert_equal("3", stat.mode)
  end

  def test_discrete_median
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("discrete")
    assert_equal(3, stat.median)
  end

  def test_discrete_mean
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("discrete")
    assert_equal(2.89, stat.mean)
  end

  def test_discrete_median
    stat = Statistic.new("1000,1800,2000,2000,2000,2800,3000,3000,3100,4000")
    stat.process_data("continuous")
    assert_equal(2001, stat.median)
  end

  # CONTINUOUS TESTS
  def test_process_continuous_variable
    stat = Statistic.new("20,26,26,27,30,31,32,36,38,40")
    stat.process_data("continuous")
    assert_equal(
    {
      1=>{"class"=>1, "at"=>[20, 27], "fi"=>3, "fr%"=>30, "F"=>"3 (1° a 3° posição)",   "F%"=>30,  "xi"=>23.5, "xi*fi"=>70.5},
      2=>{"class"=>2, "at"=>[27, 34], "fi"=>4, "fr%"=>40, "F"=>"7 (4° a 7° posição)",   "F%"=>70,  "xi"=>30.5, "xi*fi"=>122.0},
      3=>{"class"=>3, "at"=>[34, 41], "fi"=>3, "fr%"=>30, "F"=>"10 (8° a 10° posição)", "F%"=>100, "xi"=>37.5, "xi*fi"=>112.5}
    },
    stat.table)
  end

  def test_post_continuous_variable
    post '/?raw[data]=20,26,26,27,30,31,32,36,38,40&raw[distribution_type]=continuous'
    assert last_response.ok?
    assert last_response.body.include?('Processamento da variável quantitativa contínua')
  end

  def test_post_continuous_variable_without_data
    post '/?raw[data]=&raw[distribution_type]=continuous'
    assert last_response.ok?
    assert last_response.body.include?('É necessário informar os dados a serem processados, separados por vírgula.')
  end

  def test_continuous_mean
    stat = Statistic.new("1000,1800,2000,2000,2000,2800,3000,3000,3100,4000")
    stat.process_data("continuous")
    assert_equal(2201.2, stat.mean)
  end

  def test_continuous_mode_unimodal
    stat = Statistic.new("1000,1800,2000,2000,2000,2800,3000,3000,3100,4000")
    stat.process_data("continuous")
    assert_equal("1500", stat.mode)
  end

  def test_continuous_mode_bimodal
    stat = Statistic.new("1000,1800,2000,2000,2000,2800,3000,3000,3000,4000")
    stat.process_data("continuous")
    assert_equal("1500 e 2501", stat.mode)
  end

  def test_continuous_mode_multimodal
    stat = Statistic.new("1000,1000,1000,2500,3000,3000,3000,4000,4000,4000")
    stat.process_data("continuous")
    assert_equal("1500, 2501 e 3502", stat.mode)
  end

  def test_continuous_mode_amodal
    stat = Statistic.new("1000,1500,1800,2000,2500,2800,3000,3500,3800,4000")
    stat.process_data("continuous")
    assert_equal("N/A", stat.mode)
  end
end