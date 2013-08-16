class SearchesController < ApplicationController

  def index
    @company_lists = ThinkingSphinx.search params['q']['search']
  end
end
