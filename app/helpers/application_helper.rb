module ApplicationHelper

  def is_homepage?
    params[:controller] == 'application' && params[:action] == 'home'
  end

  def render_breadcrumbs_for(object)
    content_tag :ol, class: 'breadcrumb' do
      breadcrumb = content_tag :li, link_to(fa_icon('home'), root_path)
      if object.is_a? GemObject
        breadcrumb << (content_tag :li, link_to(object.gem_category.name, gem_category_path(object.gem_category))) if object.gem_category.present?
        breadcrumb << (content_tag :li, object.name, class: 'active')
      elsif object.is_a? GemCategory
        breadcrumb << (content_tag :li, link_to(object.parent.name, gem_category_path(object.parent))) if object.parent.present?
        breadcrumb << (content_tag :li, object.name, class: 'active')
      end

    end

  end

  def number_to_human_with_delimiter(number)
    return nil if number.nil?
    number_to_human(number)
  end
end
