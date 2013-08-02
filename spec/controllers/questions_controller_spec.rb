require 'spec_helper'

describe QuestionsController do

  include Devise::TestHelpers

  before(:each) do
    @user = FactoryGirl.create(:user, :confirmed_at => Time.now, :roles => ["admin"])
    sign_in @user
  end

  describe "post: Create answer" do
    it "responds successfully with an HTTP 200 status code" do
      company = FactoryGirl.create(:company)
      post :create, :company_id => company, :question => {:content => "Mitesh question"}, :format => 'js'
      expect(response.status).to eq(200)
      Question.last.content.should eq("Mitesh question")
      flash[:notice].should eq("Question Created Successfully")
    end

    it "responds failure with an HTTP 200 status code" do
      company = FactoryGirl.create(:company)
      post :create, :company_id => company, :question => {:content => nil}, :format => 'js'
      expect(response.status).to eq(200)
      Question.last.blank?.should eq(true)
      flash[:error].last.should eq("Content can't be blank")
    end
  end

end
