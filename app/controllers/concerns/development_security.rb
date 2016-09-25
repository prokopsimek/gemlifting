module DevelopmentSecurity
  extend ActiveSupport::Concern

  included do
    before_action :development_security_check
  end

  def development_security_check
    if Rails.env.production? && !Environment.current?('production')
      security_header = request.headers['X-Dev-Token'] || request.headers['x-dev-token']
      security_cookie = cookies[:x_dev_token]
      correct_access_token = ENV['X-Dev-Token']

      if (security_cookie != correct_access_token) && (security_header != correct_access_token)
        unless authenticate_with_http_basic { |user, password| user == ENV['DEV_ACCESS_USER'] && password == ENV['DEV_ACCESS_PASSWORD'] }
          request_http_basic_authentication
        else
          # if authorized, set cookie
          cookies[:x_dev_token] = { value: correct_access_token, domain: COOKIES_DOMAIN }
        end
      end
    end
  end

end
