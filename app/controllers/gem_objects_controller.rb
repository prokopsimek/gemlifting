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

  private

  def gem_object!
    @gem_object ||= GemObject.friendly.find(params[:id])
  end

end
