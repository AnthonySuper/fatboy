require_relative './viewed_item'
class Fatboy
  ##
  # TimeBasedPopularity measures the popularity based on a set period of time.
  # You should probably never initialize this yourself.
  class TimeBasedPopularity
    ##
    # What redis to look in, and what sorted set we're using.
    # Probably don't ever initialize this yourself.
    def initialize(redis, store)
      @redis = redis
      @store = store
    end
    ##
    # Get an enumerator of all viewed items, as a Fatboy::ViewedItem, in 
    # rank order.
    # Pretty useful for lazy operations and such.
    def enumerator
      Enumerator.new(size) do |yielder|
        range(0..(size-1)).each{|x| yielder.yield x}
      end
    end
    ##
    # Get the most viewed item. 
    # Returns a Fatboy::ViewedItem
    def most
      range(0..1).first
    end
    ##
    # Get the least viewed item.
    # Returns a Fatboy::ViewedItem
    def least
      range(-1..-2).first
    end

    ##
    # Get the total number of items viewed.
    def size
      @redis.zcard(@store)
    end

    ##
    # Specify a range of ranks, and gets them.
    # Returns an array of Fatboy::ViewedItem
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
