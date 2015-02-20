require_relative './viewed_item'
require_relative './helpers'
class Fatboy
  class ViewTracker
    def initialize(redis, model)
      @redis = redis
      @model_name = model.class.to_s
      @id = model.id
    end
    ##
    # How often this model was viewed this hour
    def this_hour
      hour(Time.now)
    end
    ##
    # How often this model was viewed today
    def today
      day(Time.now)
    end

    ##
    # How often this model was viewed this month
    def this_month
      day(Time.now)
    end
    ##
    # How often this model was viewed this year
    def this_year
      year(Time.now)
    end
    ##
    # How often the model was viewed on a particular hour
    def hour(time)
      time = Fatboy::Helpers.hour_format(time.utc)
      store = Fatboy::Helpers.format_store(@model_name, time)
      @redis.zscore(store, @id)
    end
   
    ##
    # How often the model was viewed in a particular day
    def day(time)
      time = Fatboy::Helpers.day_format(time.utc)
      store = Fatboy::Helpers.format_store(@model_name, time)
      get_score(store)
    end
    ##
    # How often the model was viewed in a particular month
    def month(time)
      time = Fatboy::Helpers.month_format(time.utc)
      store = Fatboy::Helpers.format_store(@model_name, time)
      get_score(store)
    end
    ##
    # How often teh model was viewed in a particular year
    def year(time)
      time = Fatboy::Helpers.month_format(time.utc)
      store = Fatboy::Helpers.format_store(@model_name, time)
      get_score(store)
    end
    protected
    def get_score(store)
      @redis.zscore(store, @id)
    end
  end
end
