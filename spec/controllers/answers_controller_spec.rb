require 'spec_helper'

describe AnswersController do

  include Devise::TestHelpers

  before(:each) do
    @user = FactoryGirl.create(:user, :confirmed_at => Time.now, :roles => ["admin"])
    sign_in @user
  end

  describe "get: New answer" do
    it "responds successfully with an HTTP 200 status code" do
      question = FactoryGirl.create(:question)
      get :new, :company_id => question.company, :question_id => question
      expect(response.status).to eq(200)
    end
  end

  describe "post: Create answer" do
    it "responds successfully with an HTTP 200 status code" do
      question = FactoryGirl.create(:question)
      post :create, :company_id => question.company, :question_id => question, :answer => {:content => "Mitesh answer"}
      expect(response.status).to eq(302)
      Answer.last.content.should eq("Mitesh answer")
    end

    it "responds failure with an HTTP 200 status code" do
      question = FactoryGirl.create(:question)
      post :create, :company_id => question.company, :question_id => question, :answer => {:content => nil}
      expect(response.status).to eq(200)
      Answer.last.blank?.should eq(true)
    end
  end

end
