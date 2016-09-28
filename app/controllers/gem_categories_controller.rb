class GemCategoriesController < ApplicationController

  # GET /categories
  def index
    
  end

  # GET /categories/:id
  def show
    category!

    @page_title = category!.name
    @page_description = category!.description
  end

  private

  def category!
    @category ||= GemCategory.friendly.find(params[:id])
    render_404 if @category.is_parental?
    @category
  end

  
end
