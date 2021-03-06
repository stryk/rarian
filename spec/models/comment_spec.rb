require "spec_helper"

describe Comment do
  it "Comment should save" do
    comment = FactoryGirl.build(:comment)
    comment.save
    comment.errors.full_messages.should eq([])
  end

  it "Comment should not save if validation fail" do
    comment = FactoryGirl.build(:comment, :comment => nil)
    comment.save
    comment.errors.full_messages.should eq(["Comment can't be blank"])
  end

  it "should have the relationship with user" do
    comment = FactoryGirl.create(:comment)
    comment.user.should_not be_nil
  end
end