class SearchesController < ApplicationController

  def index
    @company_lists = ThinkingSphinx.search params['q']['search']
    respond_to do |format|
   	  	format.js
   	end
  end

  def main
    @company_lists = ThinkingSphinx.search params['q']['search']
    respond_to do |format|
   	  	format.js
   	end
  end
end
