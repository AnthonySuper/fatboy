require 'spec_helper'
RSpec.describe Fatboy do
  it "can be initialized" do
    expect{Fatboy.new}.to_not raise_error
  end
  let(:redis){MockRedis.new}
  let(:f){Fatboy.new(redis: redis)}
  describe "storage" do
    before(:each){Timecop.freeze(Date.today)}
    after(:each){Timecop.return}
    it "ads to the redis" do
      l = Fatboy::Helpers.day_format(Time.now)
      l = Fatboy::Helpers.format_store("Model", l)
      expect{
        f.view(Model.new(10))
      }.to change{redis.zcount(l, -100, 100)}.from(0).to(1)
      f.view(Model.new(11))
      expect(redis.zscore(l, 11)).to eq(1)
    end

  end
  describe "ordering" do

    before(:each){Timecop.freeze(Date.today)}
    after(:each){Timecop.return}
    it "orders views by day" do
      2.times{f.view(Model.new(10))}
      1.times{f.view(Model.new(11))}
      expect(f.popular(Model).today.most).to eq(10)
    end
    it "orders views by month" do
      2.times{f.view(Model.new(10))}
      1.times{f.view(Model.new(11))}
      expect(f.popular(Model).this_month.most).to eq(10)
    end
    it "orders views by year" do
      2.times{f.view(Model.new(10))}
      1.times{f.view(Model.new(11))}
      expect(f.popular(Model).this_year.most).to eq(10)
    end
  end
  describe "popularity finding" do
    it "doesn't throw an error" do
      expect{f.popular(Model)}.to_not raise_error
    end
    it "returns a popularity" do
      expect(f.popular(Model)).to be_instance_of(Fatboy::Popularity)
    end
  end
end
