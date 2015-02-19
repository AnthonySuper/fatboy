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
    def most
      range(1..2).first
    end
    def range(rng)
      start = rng.first
      stop = rng.last
      @redis.zrange(@store, start, stop).map(&:to_i)
    end
  end
end
