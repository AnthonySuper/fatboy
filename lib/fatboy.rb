require "fatboy/version"
require 'redis'
require_relative './fatboy/popularity'
require_relative './fatboy/helpers'
class Fatboy
  def initialize(redis: Redis.new)
    @redis = redis
  end
  def view(obj)
    stores = Fatboy::Helpers.all_format(Time.now).map do |time|
      Fatboy::Helpers.format_store(obj.class.to_s, time)
    end
    stores.map{|store| inc_member(store, obj.id)}
  end
  ##
  # let users view with a shorthand
  alias :[] view

  def popular(model)
    Popularity.new(model, @redis)
  end
  
  HOUR_FORMAT_STR = "%Y%m%d%H"
  DAY_FORMAT_STR = "%Y%m%d"
  MONTH_FORMAT_STR = "%Y%m"
  YEAR_FORMAT_STR = "%Y"
  private
  def inc_member(store, id)
    @redis.zincrby(store, 1, id)
  end
end
