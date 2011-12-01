module Admin
  class CategoriesController < ApplicationController
    def index
      render :json => Article.all_categories
    end
  end
end
