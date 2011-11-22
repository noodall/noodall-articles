module Admin
  class CategoriesController < ApplicationController
    caches_action :index, :expires_in => 1.hour
    def index
      render :json => Article.all_categories
    end
  end
end
