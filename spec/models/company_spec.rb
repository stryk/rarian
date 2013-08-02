require "spec_helper"

describe Company do
  it "Company should save with ticker and name" do
    company = FactoryGirl.build(:company)
    company.save
    company.errors.full_messages.should eq([])
  end

  it "Company should not be saved if ticker or name are nil" do
    company = FactoryGirl.build(:company, :ticker => nil)
    company.save
    company.errors.full_messages.should_not eq([])

    company = FactoryGirl.build(:company, :name => nil)
    company.save
    company.errors.full_messages.should_not eq([])

    company = FactoryGirl.build(:company, :ticker => nil, :name => nil)
    company.save
    company.errors.full_messages.should_not eq([])
  end

  it "Company should have many blips, quotes and pitches" do
    @blip = FactoryGirl.create(:blip)
    @company = @blip.company
    @company.blips.should_not eq([])
    @company.blips.should_not be_nil
    @company.quotes.should_not be_nil
    @company.quotes.should eq([])
    @company.pitches.should eq([])
    @company.pitches.should_not be_nil
  end
end