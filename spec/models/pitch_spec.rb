require 'spec_helper'

describe Pitch do
  it "Should pass the validations" do
    pitch = FactoryGirl.create(:pitch)
    pitch.errors.full_messages.should eq([])
  end

  it "Should fail the validations" do
    pitch = FactoryGirl.build(:pitch, :title => "")
    pitch.save
    pitch.errors.full_messages.last.should match("Title can't be blank")
  end

  it "should check the relationships" do
    pitch = FactoryGirl.create(:pitch)
    pitch.user.should_not be_nil
    pitch.company.should_not be_nil
  end

  it "get_full_title: should return the full_title" do
    pitch = FactoryGirl.create(:pitch)
    pitch.get_full_title.should match(pitch.created_at.strftime("%m/%d/%Y")+": "+pitch.action+": "+pitch.title)
  end
end
