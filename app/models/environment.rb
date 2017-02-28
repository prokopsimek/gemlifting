class Environment
  class << self
    # If more than one environment name is provided, returns true if at least one of them
    # matches the current environment.
    def current?(*environment_names)
      environment_names.each do |string|
        return true if string.in?(%w(local localhost)) && Rails.env.development?
        return true if string == 'test' && Rails.env.test?

        next unless Rails.env.production? || Rails.env.test?
        return true if string.in?(%w(development-online development)) && ENV['ENV_FLAVOR'] == 'development-online'
        return true if string == 'staging' && ENV['ENV_FLAVOR'] == 'staging'
        return true if string == 'production' && ENV['ENV_FLAVOR'] == 'production'
      end
      false
    end

    # this method returns environment flavor if exits
    def env_tag
      tag = if current?('development-online staging production')
              ENV['ENV_FLAVOR'].to_s
            else
              Rails.env
            end

      tag
    end

    def env_subdomain
      return 'dev' if current?('development-online')
      return 'staging' if current?('staging')
      return 'www' if current?('production')
    end
  end
end
