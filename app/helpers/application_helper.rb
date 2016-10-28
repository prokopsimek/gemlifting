module ApplicationHelper

  def is_homepage?
    params[:controller] == 'application' && params[:action] == 'home'
  end
end
