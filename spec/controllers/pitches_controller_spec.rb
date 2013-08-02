require 'spec_helper'

describe PitchesController do
  include Devise::TestHelpers

  before(:each) do
    @user = FactoryGirl.create(:user, :confirmed_at => Time.now, :roles => ["admin"])
    sign_in @user
  end

  describe "Get: New pitch form" do
    it "responds successfully with an HTTP 200 status code" do
      company = FactoryGirl.create(:company)
      get :new, {:company_id => company, :format => 'js', :action_type => "buy"}
      expect(response.status).to eq(200)
    end
  end

  describe "Post: Create pitch" do
    it "responds successfully with an HTTP 302 status code" do
      company = FactoryGirl.create(:company)
      post :create, {:pitch => FactoryGirl.build(:pitch).attributes}.merge(:format => 'js', :company_id => company)
      expect(response.status).to eq(302)
      response.should redirect_to(company_path(company))
    end

    it "responds failure with an HTTP 200 status code" do
      company = FactoryGirl.create(:company)
      post :create, {:pitch => FactoryGirl.build(:pitch, :title => "").attributes}.merge(:format => 'js', :company_id => company)
      expect(response.status).to eq(200)
      flash[:error].should_not be_nil
    end
  end

end
