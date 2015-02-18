require 'spec_helper'

RSpec.describe Fatboy do
  it "can be initialized" do
    expect{Fatboy.new}.to_not raise_error
  end
end
