require 'spec_helper'

RSpec.describe Fatboy::ViewTracker do
  let(:redis){MockRedis.new}
  let(:f){Fatboy.new redis: redis}
  it "views based on time period" do
    Timecop.travel(Date.today) do
      m = Model.new(10)
      f[m]
      expect(f.views_for(m).this_hour).to eq(1)
      expect(f.views_for(m).today).to eq(1)
      expect(f.views_for(m).this_month).to eq(1)
      expect(f.views_for(m).this_year).to eq(1)
    end
  end
end
