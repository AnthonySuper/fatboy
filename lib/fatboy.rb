require "fatboy/version"

class Fatboy
  def initialize(redis: Redis.new)
    @redis = redis
  end
  alias :[] :view
  def view(obj)

  end

  private

  def db_times
    [:hour_str, :day_str, :month_str, :year_str].map do |method|
      self.send method
    end
  end

  ## 
  # This function takes a format string and returns the date formatted
  # accordingly. It exists so we don't have to type "Time.not.utc.strftime"
  # a billion time
  def format_time format
    Time.now.utc.strftime format
  end
  ##
  # identify views per hour
  def hour_str
    format_time "%Y%m%d%H"
  end
  def day_str
    format_time "%Y%m%d"
  end
  def month_str
    format_time "%Y%m"
  end
  def year_str
    format_time "%Y"
  end
end
