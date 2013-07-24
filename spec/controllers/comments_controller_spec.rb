require 'spec_helper'

describe CommentsController do
  include Devise::TestHelpers

  before(:each) do
    @user = FactoryGirl.create(:user, :confirmed_at => Time.now, :roles => ["admin"])
    sign_in @user
  end

  describe "Get: Index all the commets of a blip" do
    it "responds successfully with an HTTP 200 status code" do
      blip = FactoryGirl.create(:blip)
      get :index, {:blip_id => blip.id, :format => 'js'}
      expect(response.status).to eq(200)
    end
  end

  describe "Post: Create a comment for a blip" do
    it "responds successfully with an HTTP 200 status code" do
      blip = FactoryGirl.create(:blip)
      get :create, {:blip_id => blip.id, :comment => {:comment => "This is a test comment"}, :format => 'js'}
      expect(response.status).to eq(200)
      flash[:notice].should eq("Comment Created Successfully")
    end

    it "fail to create the comment as comment is required field" do
      blip = FactoryGirl.create(:blip)
      get :create, {:blip_id => blip.id, :comment => {:comment => ""}, :format => 'js'}
      expect(response.status).to eq(200)
      flash[:error].last.should eq("Comment can't be blank")
      Comment.all.should eq([])
    end
  end


end
