#encoding: utf-8

class Statistic
  attr_reader :ranked_data,       # Sorted array of numbers (rol)
              :uniq_count,        # Hash with the sum of each element
              :table,             # Hash with the complete statistical data
              :mode,              # http://en.wikipedia.org/wiki/Mode_(statistics)
              :median,            # http://en.wikipedia.org/wiki/Median_(statistics)
              :mean,              # http://en.wikipedia.org/wiki/Mean_(statistics)
              :class_range,       # at = (Xmax - Xmin) + 1)
              :number_of_classes, # k = Math.sqrt(@ranked_data.length)
              :class_interval,    # ic = @class_range / @number_of_classes
              :distribution_type, # discrete or continuous
              :median_class       # Position on table hash used to calculate the median (continuous)

  def initialize(raw_data)
    setup_ranked_data(raw_data)
    setup_uniq_count
  end

  def process_data(distribution_type)
    case distribution_type
      when "discrete"   then process_discrete_distribution
      when "continuous" then process_continuous_distribution
      else return @table = "Invalid distribution type."
    end
    
    calculate_measure_of_central_tendency
  end

  def self.version
    "0.0.1"
  end

 private
  def setup_ranked_data(raw_data)
    @ranked_data = raw_data.split(",").map { |s| s.to_i }
    @ranked_data.sort!
  end

  def setup_uniq_count
    @uniq_count = Hash.new(0)
    @ranked_data.uniq.each { |element| @uniq_count[element] = @ranked_data.count(element) }
  end

  def process_discrete_distribution
    # http://en.wikipedia.org/wiki/List_of_probability_distributions#Discrete_distributions

    @distribution_type = "discrete"
    @table = Hash.new(0)
    accumulated_frequency = 0

    @uniq_count.each_with_index do |element, i|
      @table[i] = Hash.new(0)
      @table[i]["xi"] = element[0]
      @table[i]["fi"] = element[1]
      @table[i]["fr%"] = (element[1]*100) / @ranked_data.length

      accumulated_frequency += element[1]
      @table[i]["F"] = accumulated_frequency
      @table[i]["F%"] = (accumulated_frequency * 100) / @ranked_data.length
      @table[i]["xi*fi"] = element[0] * element[1]
    end
  end

  def process_continuous_distribution
    # http://en.wikipedia.org/wiki/List_of_probability_distributions#Continuous_distributions

    @distribution_type = "continuous"
    @class_range = (@ranked_data.last - @ranked_data.first) + 1
    @number_of_classes = Math.sqrt(@ranked_data.length).to_i

    find_ideal_class_interval

    @table = Hash.new(0)
    accumulated_frequency = 0
    lower_interval = @ranked_data.first

    for i in 1..@number_of_classes
      @table[i] = Hash.new(0)
      @table[i]["class"] = i
      @table[i]["at"] = [lower_interval, lower_interval + class_interval]
      
      frequence = count_between(lower_interval, lower_interval + class_interval)
      @table[i]["fi"] = frequence
      @table[i]["fr%"] = (frequence*100) / @ranked_data.length

      accumulated_frequency += frequence
      @table[i]["F"] = "#{accumulated_frequency} #{frequence_position(i, accumulated_frequency, frequence)}"
      @table[i]["F%"] = (accumulated_frequency * 100) / @ranked_data.length

      xi = (lower_interval + (lower_interval + class_interval).to_f) / 2.0
      @table[i]["xi"] = xi
      @table[i]["xi*fi"] = xi * frequence.to_f
      
      lower_interval += class_interval
    end
  end

  def count_between(lower, upper)
    @ranked_data.count { |v| v.between?(lower, (upper - 1)) }
  end

  def frequence_position(index, accumulated_frequency, frequence)
    # 0 elements
    return "" if frequence == 0

    # 1 element
    @median_class = index if (@ranked_data.length / 2) == frequence
    return "(#{accumulated_frequency}° posição)" if frequence == 1

    # n elements
    mid = (@ranked_data.length / 2)
    @median_class = index if mid >= (accumulated_frequency - frequence + 1) && mid <= accumulated_frequency
    "(#{accumulated_frequency - frequence + 1}° a #{accumulated_frequency}° posição)"
  end

  def find_ideal_class_interval
    attempts = -1
    begin
      if attempts == 2
        @class_range += 1
        attempts = 0
      else
        attempts += 1
      end

      case attempts
        when 0 then @class_interval = @class_range / @number_of_classes
        when 1 then @class_interval = @class_range / (@number_of_classes - 1)
        when 2 then @class_interval = @class_range / (@number_of_classes + 1)
      end
    end while @class_range % @number_of_classes > 0
  end

  def calculate_measure_of_central_tendency
    # http://en.wikipedia.org/wiki/Central_tendency

    calculate_mode
    calculate_median
    calculate_mean
  end

  def calculate_mode
    max = @uniq_count.values.max
    elements = @uniq_count.select { |k, v| v == max}

    return @mode = "N/A" if max == 1

    if @distribution_type == "discrete"
      calculate_discrete_mode(elements)
    else
      calculate_continuous_mode(max, elements)
    end
  end

  def calculate_discrete_mode(elements)
    arr_mode = elements.map { |element| element[0] }
    @mode = arr_mode.uniq.to_sentence
  end

  def calculate_continuous_mode(max, elements)
    arr_mode = Array.new

    elements.each do |element|
      @table.each do |row|
        lower_range, upper_range = row[1]["at"][0], row[1]["at"][1]
        arr_mode << (lower_range + upper_range).to_f / 2.to_f if element[0].between?(lower_range, upper_range)
      end
    end

    @mode = arr_mode.uniq.to_sentence
  end

  def calculate_mean
    mean_sum = @table.map { |h| h[1]["xi*fi"] }.reduce(:+)
    @mean = (mean_sum.to_f / @ranked_data.length.to_f).round(2)
  end

  def calculate_median
    if @distribution_type == "discrete"
      calculate_discrete_median
    else
      calculate_continuous_median
    end
  end

  def calculate_discrete_median
    mid = @ranked_data.length / 2
    @median = if @ranked_data.length % 2 == 0
      (@ranked_data[mid].to_f + @ranked_data[mid - 1].to_f) / 2.to_f
    else
      @ranked_data[mid + 1]
    end
  end

  def calculate_continuous_median
    mid = @ranked_data.length / 2
    lower_range = @table[@median_class]["at"][0]
    previous_f = @median_class == 1 ? 0 : @table[@median_class - 1]["F"].split(" ")[0].to_i
    
    @median = lower_range + (((mid - previous_f).to_f / @table[@median_class]["fi"].to_f) * @class_interval)
  end
end