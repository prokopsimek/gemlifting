class GemCategoriesController < ApplicationController

  # GET /categories
  def index
    
  end

  # GET /categories/:id
  def show
    find_category
  end

  private

  def find_category
    @category = GemCategory.friendly.find(params[:id])
    render_404 if @category.is_parental?
  end

  
end
