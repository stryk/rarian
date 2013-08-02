require 'spec_helper'

describe BlipsController do
  include Devise::TestHelpers

  before(:each) do
    @user = FactoryGirl.create(:user, :confirmed_at => Time.now, :roles => ["admin"])
    sign_in @user
  end

  describe "get: Index blip" do
    it "responds successfully with an HTTP 200 status code" do
      blip = FactoryGirl.create(:blip)
      get :index, :company_id => blip.company, :sort_by => "asc", :format => 'js'
      expect(response.status).to eq(200)
    end

    it "responds successfully with an HTTP 200 status code" do
      blip = FactoryGirl.create(:blip)
      get :index, :company_id => blip.company, :sort_by => "desc", :format => 'js'
      expect(response.status).to eq(200)
    end
  end

  describe "Post: Create blip" do
    it "responds successfully with an HTTP 200 status code" do
      post :create, FactoryGirl.build(:blip).attributes.merge!(:format => 'js')
      expect(response.status).to eq(200)
    end
  end
end
