require 'spec_helper'

RSpec.describe Fatboy do
  it "can be initialized" do
    expect{Fatboy.new}.to_not raise_error
  end
  describe "ordering" do
    before(:each){Timecop.freeze(Date.today)}
    after(:each){Timecop.return}
    let(:redis){MockRedis.new}
    let(:f){Fatboy.new(redis)}
    it "orders views by day" do
      2.times{f.view(Model.new(10))}
      1.times{f.view(Model.new(11))}
      expect(f.popular(Model).today).to eq(10)
    end
    it "orders views by month" do
      2.times{f.view(Model.new(10))}
      1.times{f.view(Model.new(11))}
      expect(f.popular(Model).this_month).to eq(10)
    end
    it "orders by hour" do
      2.times{f.view(Model.new(10))}
      1.times{f.view(Model.new(11))}
      expect(f.popular(Model).this_year).to eq(10)
    end
  end
end
