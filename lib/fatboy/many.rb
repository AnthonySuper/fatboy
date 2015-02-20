class Fatboy
  ##
  # This class provides a way to pipeline many different views, adding 
  # efficiency.
  # Usage:
  #
  #   m = fatboy.many
  #   m[image]
  #   m[comment]
  #   m[comment2]
  #   m[description]
  #   m.commit!
  class Many
    ##
    # Don't initialize this yourself.
    def initialize(redis)
      @redis = redis
      @models = []
    end
    ##
    # Alias for view
    def [](o)
      view o
    end
    def view(obj)
      @models << obj
    end

    def commit!
      stores = Fatboy::Helpers.all_format(Time.now)
      @redis.pipelined do
        @models.each do |model|
          redis_view(model, stores)
        end
      end
    end
    protected
    ##
    # Basically copy/pasted from the Fatboy class.
    # The second argument is so that we don't need to calculate the time
    # string multiple times.
    def redis_view(model, stores)
      stores.each do |store|
        inc_member(store, model.id)
      end
    end

    def inc_member(store, id)
      @redis.zincrby(store, 1, id)
    end
  end
end
