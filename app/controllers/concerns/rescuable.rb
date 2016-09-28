module Rescuable
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do
      render_404
    end
  end

  def render_404
    respond_to do |format|
      format.html { render 'errors/404', status: :not_found }
      format.all { render plain: 'Not found', status: :not_found }
    end
  end
end
