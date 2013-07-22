require 'spec_helper'

describe BlipsController do
  include Devise::TestHelpers

  before(:each) do
    @user = FactoryGirl.create(:user, :confirmed_at => Time.now, :roles => ["admin"])
    sign_in @user
  end

  describe "Post: Create blip" do
    it "responds successfully with an HTTP 200 status code" do
      post :create, FactoryGirl.build(:blip).attributes.merge!(:format => 'js')
      expect(response.status).to eq(200)
    end
  end

  describe "Put: vote_up" do
    it "responds successfully with an HTTP 200 status code" do
      blip = FactoryGirl.create(:blip)
      put :vote_up, {:id => blip.id, :format => 'js'}
      expect(response.status).to eq(200)
      @user.up_voted?(blip).should eq(true)
    end

    it "responds successfully with an HTTP 200 status code and removing the given vote" do
      blip = FactoryGirl.create(:blip)
      @user.up_vote(blip)
      put :vote_up, {:id => blip.id, :format => 'js'}
      expect(response.status).to eq(200)
      @user.up_voted?(blip).should eq(false)
    end
  end

  describe "Put: vote_down" do
    it "responds successfully with an HTTP 200 status code" do
      blip = FactoryGirl.create(:blip)
      put :vote_down, {:id => blip.id, :format => 'js'}
      expect(response.status).to eq(200)
      @user.down_voted?(blip).should eq(true)
    end

    it "responds successfully with an HTTP 200 status code" do
      blip = FactoryGirl.create(:blip)
      @user.down_vote(blip)
      put :vote_down, {:id => blip.id, :format => 'js'}
      expect(response.status).to eq(200)
      @user.down_voted?(blip).should eq(false)
    end
  end
end
