require_relative './time_based_popularity'
class Fatboy
  ##
  # This class is used to query how popular something is. 
  class Popularity
    ##
    # We always pass in a redis
    def initialize(model, redis)
      @redis = redis
      @model_name  = model.to_s
    end
    ##
    # Get a Fatboy::TimeBasedPopularity for a specific hour in time.
    # Arguments:
    #  * +time+: a DateTime or Time containing the hour in time you wish to query
    def hour(time)
      fmt_tim = Fatboy::Helpers.hour_format(time.utc)
      store_name = Fatboy::Helpers.format_store(@model_name, fmt_tim)
      Fatboy::TimeBasedPopularity.new(@redis, store_name)
    end
    ##
    # Get a Fatboy::TimeBasedPopularity for a specific day in time.
    # Arguments:
    #  * +time+: A Datetime or Time in the day you wish to query.
    def day(time)
      fmt_time = Fatboy::Helpers.day_format(time.utc)
      store_name = Fatboy::Helpers.format_store(@model_name, fmt_time)
      
      Fatboy::TimeBasedPopularity.new(@redis, store_name)
    end
    ##
    # Get a Fatboy::TimeBasedPopularity for a specific month in time.
    # Arguments:
    #  * +time+: A time within the month you wish to query.
    def month(time)
      fmt_time = Fatboy::Helpers.month_format(time.utc)
      store_name = Fatboy::Helpers.format_store(@model_name, fmt_time)
      Fatboy::TimeBasedPopularity.new(@redis, store_name)
    end
    ##
    # Get a Fatboy::TimeBasedPopularity for a specific year in time.
    # Arguments:
    #  * +time+: A DateTime or Time in the year you wish to query.
    def year(time)
      fmt_time = Fatboy::Helpers.year_format(time.utc)
      store_name = Fatboy::Helpers.format_store(@model_name, fmt_time)
      Fatboy::TimeBasedPopularity.new(@redis, store_name)
    end
    ##
    # Get a Fatboy::TimeBasedPopularity for this hour.
    def this_hour
      hour(Time.now)
    end
    ##
    # Get a Fatboy::TimeBasedPopularity for this day.
    def today
      day(Time.now)
    end
    ##
    # Get a Fatboy::TimeBasedPopularity for this month.
    def this_month
      month(Time.now)
    end
    ##
    # Get a Fatboy::TimeBasedPopularity for this year. 
    def this_year
      year(Time.now)
    end
  end
end
