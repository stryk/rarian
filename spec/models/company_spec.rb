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
end