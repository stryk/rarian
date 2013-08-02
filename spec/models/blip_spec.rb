require "spec_helper"

describe Blip do
  it "order by created_at DESC so i should see sell in the first" do
    @blip = FactoryGirl.create(:blip)
    @blip = FactoryGirl.create(:blip, :user => FactoryGirl.create(:user, :email => "mitesh@mail.com"), :action => "sell")
    Blip.all.first.action.should eq("sell")
  end

  it "blip should not be created if action is not buy or sell" do
    @blip = FactoryGirl.build(:blip, :action => "dont_buy")
    @blip.save
    @blip.errors.full_messages.should_not eq([])
  end

  it "blip validation" do
    @blip = FactoryGirl.build(:blip, :content => nil)
    @blip.save

    @blip.errors.messages[:content].should_not eq([])

    @blip.content = "test blip"
    @blip.company = nil
    @blip.save
    @blip.errors.messages[:content].should eq(nil)
    @blip.errors.messages[:company].should_not eq([])


    @blip.company = FactoryGirl.create(:company)
    @blip.user = nil
    @blip.save
    @blip.errors.messages[:content].should eq(nil)
    @blip.errors.messages[:company].should eq(nil)
    @blip.errors.messages[:user].should_not eq([])
  end

  it "should return the full title" do
    @blip = FactoryGirl.create(:blip)
    @blip.get_full_title.should match(@blip.company.ticker+": "+@blip.created_at.strftime("%m/%d/%Y")+": "+@blip.action+": "+@blip.content)
  end
end