class Fatboy
  ##
  # The viewed item class provides a (very) simple interface for interacting
  # with views on Models.
  # Almost always obtained from a TimeBasedPopularity, this struct simply
  # shows the id of the model, the number of views, and the rank.
  # NOTE: The highest-ranked item has rank 0. Ranks are 0-indexed.
  class ViewedItem
    def initialize(id, views, rank)
      @id = id.to_i
      @views = views.to_i
      @rank = rank.to_i
    end
    attr_reader :id
    attr_reader :views
    attr_reader :rank
  end
end

