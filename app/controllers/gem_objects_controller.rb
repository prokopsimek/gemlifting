class GemObjectsController < ApplicationController

  # GET /gems
  def index

  end

  # GET /gems/:id
  def show
    gem_object!

    @page_title = gem_object!.name
    @page_description = gem_object!.description
  end

  def search
    query = params[:query]

    begin
      redirect_to :back and return if query.blank?
    rescue ActionController::RedirectBackError
      redirect_to root_path and return
    end

    @gem_objects = GemObject.search(query)

    @page_title = "Search \"#{query}\""
    @page_description = "Search results for text \"#{query}\""
  end

  private

  def gem_object!
    @gem_object ||= GemObject.friendly.find(params[:id])
  end

end
