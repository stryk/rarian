require 'spec_helper'

describe VotesController do
  include Devise::TestHelpers

  before(:each) do
    @user = FactoryGirl.create(:user, :confirmed_at => Time.now, :roles => ["admin"])
    sign_in @user
  end

  describe "Put: vote_up" do
    it "responds successfully with an HTTP 200 status code" do
      blip = FactoryGirl.create(:blip)
      put :up, {:blip_id => blip.id, :company_id => blip.company, :format => 'js'}
      expect(response.status).to eq(200)
      @user.up_voted?(blip).should eq(true)
    end

    it "responds successfully with an HTTP 200 status code and removing the given vote" do
      blip = FactoryGirl.create(:blip)
      @user.up_vote(blip)
      put :up, {:blip_id => blip.id, :company_id => blip.company, :format => 'js'}
      expect(response.status).to eq(200)
      @user.up_voted?(blip).should eq(false)
    end

    it "responds successfully with an HTTP 200 status code" do
      pitch = FactoryGirl.create(:pitch)
      put :up, {:pitch_id => pitch.id, :company_id => pitch.company, :format => 'js'}
      expect(response.status).to eq(200)
      @user.up_voted?(pitch).should eq(true)
    end

    it "responds successfully with an HTTP 200 status code and removing the given vote" do
      pitch = FactoryGirl.create(:pitch)
      @user.up_vote(pitch)
      put :up, {:pitch_id => pitch.id, :company_id => pitch.company, :format => 'js'}
      expect(response.status).to eq(200)
      @user.up_voted?(pitch).should eq(false)
    end
  end

  describe "Put: vote_down" do
    it "responds successfully with an HTTP 200 status code" do
      blip = FactoryGirl.create(:blip)
      put :down, {:blip_id => blip.id, :company_id => blip.company, :format => 'js'}
      expect(response.status).to eq(200)
      @user.down_voted?(blip).should eq(true)
    end

    it "responds successfully with an HTTP 200 status code" do
      blip = FactoryGirl.create(:blip)
      @user.down_vote(blip)
      put :down, {:blip_id => blip.id, :company_id => blip.company, :format => 'js'}
      expect(response.status).to eq(200)
      @user.down_voted?(blip).should eq(false)
    end

    it "responds successfully with an HTTP 200 status code" do
      pitch = FactoryGirl.create(:pitch)
      put :down, {:pitch_id => pitch.id, :company_id => pitch.company, :format => 'js'}
      expect(response.status).to eq(200)
      @user.down_voted?(pitch).should eq(true)
    end

    it "responds successfully with an HTTP 200 status code" do
      pitch = FactoryGirl.create(:pitch)
      @user.down_vote(pitch)
      put :down, {:pitch_id => pitch.id, :company_id => pitch.company, :format => 'js'}
      expect(response.status).to eq(200)
      @user.down_voted?(pitch).should eq(false)
    end
  end

  describe "User vote his own blip or pitch" do
    it "should not be able to down vote own blip" do
      @user.roles=["standard"]
      @user.save
      blip = FactoryGirl.create(:blip, :user => @user)
      put :down, {:blip_id => blip.id, :company_id => blip.company, :format => 'js'}
      expect(response.status).to eq(200)
      @user.down_voted?(blip).should eq(false)
    end

    it "should not be able to down vote own pitch" do
      @user.roles=["standard"]
      @user.save
      pitch = FactoryGirl.create(:pitch, :user => @user)
      put :down, {:pitch_id => pitch.id, :company_id => pitch.company, :format => 'js'}
      expect(response.status).to eq(200)
      @user.down_voted?(pitch).should eq(false)
    end

    it "should not be able to up vote own blip" do
      @user.roles=["standard"]
      @user.save
      blip = FactoryGirl.create(:blip, :user => @user)
      put :up, {:blip_id => blip.id, :company_id => blip.company, :format => 'js'}
      expect(response.status).to eq(200)
      @user.up_voted?(blip).should eq(false)
    end

    it "should not be able to up vote own pitch" do
      @user.roles=["standard"]
      @user.save
      pitch = FactoryGirl.create(:pitch, :user => @user)
      put :up, {:pitch_id => pitch.id, :company_id => pitch.company, :format => 'js'}
      expect(response.status).to eq(200)
      @user.up_voted?(pitch).should eq(false)
    end
  end
end