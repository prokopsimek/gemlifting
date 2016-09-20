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
      tag = if ENV['ENV_FLAVOR'].to_s == 'production'
              'www'
            elsif ENV['ENV_FLAVOR'].to_s == 'staging'
              'staging'
            elsif (ENV['ENV_FLAVOR'].to_s == 'development-online') && ENV['ENV_SUB_FLAVOR'].blank?
              'dev'
            else
              Rails.env
            end

      tag
    end
  end
end
