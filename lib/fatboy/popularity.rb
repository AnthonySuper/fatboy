require_relative './time_based_popularity'
class Fatboy
  ##
  # This class is used to query how popular something is
  class Popularity
    ##
    # We always pass in a redis
    def initialize(model, redis)
      @redis = redis
      @model_name  = model.to_s
    end

    def hour(time)
      fmt_tim = Fatboy::Helpers.hour_format(time.utc)
      store_name = Fatboy::Helpers.format_store(@model_name, fmt_tim)
      Fatboy::TimeBasedPopularity.new(@redis, store_name)
    end

    def day(time)
      fmt_time = Fatboy::Helpers.day_format(time.utc)
      store_name = Fatboy::Helpers.format_store(@model_name, fmt_time)
      
      Fatboy::TimeBasedPopularity.new(@redis, store_name)
    end

    def month(time)
      fmt_time = Fatboy::Helpers.month_format(time.utc)
      store_name = Fatboy::Helpers.format_store(@model_name, fmt_time)
      Fatboy::TimeBasedPopularity.new(@redis, store_name)
    end
    def year(time)
      fmt_time = Fatboy::Helpers.year_format(time.utc)
      store_name = Fatboy::Helpers.format_store(@model_name, fmt_time)
      Fatboy::TimeBasedPopularity.new(@redis, store_name)
    end
    ##
    # Helper method to get the most popular this hour
    def this_hour
      hour(Time.now)
    end
    ##
    # Helper method to get the most popular today
    def today
      day(Time.now)
    end
    ##
    # Helper method to get the most popular this month
    def this_month
      month(Time.now)
    end
    ##
    # Helper method to get the most popular this year
    def this_year
      year(Time.now)
    end
  end
end
