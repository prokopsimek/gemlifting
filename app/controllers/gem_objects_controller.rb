class GemObjectsController < ApplicationController

  # GET /gems
  def index

  end

  # GET /gems/:id
  def show
    find_gem_object
  end

  private

  def find_gem_object
    @gem_object = GemObject.friendly.find(params[:id])
  end


end
