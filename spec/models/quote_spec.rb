require "spec_helper"

describe Quote do
  it "Quote should save with price and date_time" do
    quote = FactoryGirl.build(:quote)
    quote.save
    quote.errors.full_messages.should eq([])
  end

  it "Quote should not be saved if price or date_time are nil" do
    quote = FactoryGirl.build(:quote, :price => nil)
    quote.save
    quote.errors.full_messages.should_not eq([])

    quote = FactoryGirl.build(:quote, :date_time => nil)
    quote.save
    quote.errors.full_messages.should_not eq([])

    quote = FactoryGirl.build(:quote, :price => nil, :date_time => nil)
    quote.save
    quote.errors.full_messages.should_not eq([])
  end
end