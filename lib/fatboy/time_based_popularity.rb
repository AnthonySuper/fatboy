class Fatboy
  ##
  # TimeBasedPopularity measures the popularity based on a set period of time.
  # You should probably never initialize this yourself.
  class TimeBasedPopularity
    ##
    # What redis to look in, and what sorted set we're using
    def initialize(redis, store)
      @redis = redis
      @store = store
    end
  end
end
