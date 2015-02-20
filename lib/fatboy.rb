require "fatboy/version"
require 'redis'
require_relative './fatboy/popularity'
require_relative './fatboy/helpers'
require_relative './fatboy/view_tracker'
##
# Fatboy is the main class for interacting with the system.
# It provides a variety of functionality.
class Fatboy
  ##
  # Create a new Fatboy.
  # Options:
  #  * +redis:+ : The redis to store views in. By default, Redis.new
  def initialize(redis: Redis.new)
    @redis = redis
  end

  def views_for(model)
    Fatboy::ViewTracker.new(@redis, model)
  end
  ##
  # Say that you have viewed an object, making the proper records for
  # hour, day, month, and year.
  # * +model+ - a model of some sort. Should quack like an ActiveRecord model (that is, responding to .id)
  def view(obj)
    throw ArgumentError.new("That doesn't quack like a model!") unless obj.respond_to?(:id)
    stores = Fatboy::Helpers.all_format(Time.now).map do |time|
      Fatboy::Helpers.format_store(obj.class.to_s, time)
    end
    @redis.pipelined do
      stores.each do |store|
        inc_member(store, obj.id)
      end
    end
  end
  ##
  # let users view with a shorthand
  def [](obj)
    view(obj)
  end
  ##
  # This method returns a Fatboy::Popularity, the main interface for
  # determining the popularity of your models.
  # Example:
  #   fatboy.popular(Image)
  #   fatboy.popular("Image")
  #   fatboy.popular(model.class)
  def popular(model)
    Popularity.new(model, @redis)
  end
  ##
  # Format string we use to store the views per hour
  HOUR_FORMAT_STR = "%Y%m%d%H"
  ##
  # Format string we use to store the views per day
  DAY_FORMAT_STR = "%Y%m%d"
  ##
  # Format string we use to store the views per month
  MONTH_FORMAT_STR = "%Y%m"
  ##
  # Format string we use to store the views per year
  YEAR_FORMAT_STR = "%Y"
  private
  def inc_member(store, id)
    @redis.zincrby(store, 1, id)
  end
end
