INFLUX_CONNECTION = if Rails.env.production?
                      ENV['INFLUX_CONNECTION']
                    else
                      'user@pass@database@host'
                    end
