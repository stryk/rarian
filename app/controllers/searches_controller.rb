class SearchesController < ApplicationController

  def index
    @company_lists = []
    @company_lists = Company.search params['name_startsWith'], :star => true, :field_weights => {
      :ticker => 10,
      :name    => 5
    } unless params['name_startsWith'].strip.blank?
    options = []
    
    options << {:id => '', :name => "Companies", :divider => true} if !@company_lists.blank?

    @company_lists.each do |company|
      options << {:id => company.id, :name => company.name + "-" + company.ticker, :divider => '', :url => company_path(company)}
    end

    @user_lists = []
    @user_lists = User.search '*'+params['name_startsWith']+'*' unless params['name_startsWith'].strip.blank?

    options << {:id => '', :name => "Members", :divider => true} unless @user_lists.blank?

    @user_lists.each do |user|
      options << {:id => user.id, :name => user.name, :divider => '', :url => user_path(user)}
    end

    render :json => {:options => options}
    # respond_to do |format|
   	  	# format.js
   	# end
  end

  def main
    @company_lists = ThinkingSphinx.search params['q']['search']
    respond_to do |format|
   	  	format.js
   	end
  end
end
