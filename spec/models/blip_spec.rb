require "spec_helper"

describe Blip do
  it "order by created_at DESC so i should see sell in the first" do
    @blip = FactoryGirl.create(:blip)
    @blip = FactoryGirl.create(:blip, :user => FactoryGirl.create(:user, :email => "mitesh@mail.com"), :action =>  "sell")
    Blip.all.first.action.should eq("sell")
  end
end