require 'spec_helper'
RSpec.describe Fatboy do
  it "can be initialized" do
    expect{Fatboy.new}.to_not raise_error
  end
  before(:each){Timecop.freeze(Date.today)}
  after(:each){Timecop.return}
  let(:redis){MockRedis.new}
  let(:f){Fatboy.new(redis: redis)}
  describe "ordering" do
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
