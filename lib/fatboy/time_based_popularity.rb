require_relative './viewed_item'
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
      range(0..1).first
    end
    def least
      range(-1..-2).first
    end
    def size
      @redis.zcard(@store)
    end
    def range(rng)
      start = rng.first
      stop = rng.last
      ##
      # Build up a list of pairs: [id, score]
      pairs = @redis.zrevrange(@store, start, stop, withscores: true)
      ##
      # Get rid of nils, zip up list with range of rank
      triplets = pairs.reject{|p| !p}.zip(start..stop)
      # After the zip, we have [[[id, score], rank], [[id, score], rank]]
      # So we flatten out the inner arrays, giving us
      # [[id, score, rank], [id, score, rank]]
      triplets.map!(&:flatten)
      ##
      # Use the array splat to more easily pass in the 3 arguments
      triplets.map{|trip| Fatboy::ViewedItem.new(*trip)}
    end
  end
end
