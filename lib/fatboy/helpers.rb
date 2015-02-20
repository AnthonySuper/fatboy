class Fatboy
  ##
  # Common helper functions, which are used across many
  # classes.
  module Helpers
    ##
    # Given a model_name and the properly formated hour, day, etc. string,
    # give the name of the key views are stored in
    def self.format_store(model_name, store_name)
      "#{model_name}-#{store_name}"
    end
    ##
    # Properly format the time to retrieve or set an hour
    def self.hour_format(hr)
      hr.utc.strftime(Fatboy::HOUR_FORMAT_STR)
    end

    ##
    # Properly format the time to retrieve or set a day
    def self.day_format(day)
      day.utc.strftime(Fatboy::DAY_FORMAT_STR)
    end

    ##
    # Properly format the time to retrieve or set a month
    def self.month_format(mth)
      mth.utc.strftime(Fatboy::MONTH_FORMAT_STR)
    end

    ##
    # Properly format the time to retrieve or set a year
    def self.year_format(yr)
      yr.utc.strftime(Fatboy::YEAR_FORMAT_STR)
    end
    ##
    # Get an array of the hour format, the day format, the month format, and
    # the year format
    def self.all_format(time)
      [:hour_format, :day_format, :month_format, :year_format].map do |func|
        self.send(func, time)
      end
    end
  end
end
