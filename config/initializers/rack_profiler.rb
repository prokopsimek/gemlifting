unless Environment.current?('production')
  require 'rack-mini-profiler'

  # initialization is skipped so trigger it
  Rack::MiniProfilerRails.initialize!(Rails.application)
end
