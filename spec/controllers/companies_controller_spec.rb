require 'spec_helper'

describe CompaniesController do
  include Devise::TestHelpers

  before(:each) do
    @user = FactoryGirl.create(:user, :confirmed_at => Time.now, :roles => ["admin"])
    sign_in @user
  end

  describe "Get: Index Company " do
    it "responds successfully with an HTTP 200 status code" do
      FactoryGirl.create(:company)
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "Get: Show Company " do
    it "responds successfully with an HTTP 200 status code" do
      company = FactoryGirl.create(:company)
      get :show, :id => company.id
      expect(response.status).to eq(200)
    end

    it "response failure with an HTTP 403 status code" do
      get :show, :id => 2
      expect(response.status).to eq(403)
    end
  end

end
