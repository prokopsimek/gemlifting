class SitemapRefreshJob < SidekiqJobBase # This is a Sidekiq job, not the normal ActiveJob, beacuse of scheduling
  require 'rake'
  Gemlifting::Application.load_tasks

  def perform
    Rails.logger.info '========== REFRESHING SITEMAP =========='
    cmd = Environment.current?('production') ? 'sitemap:refresh' : 'sitemap:refresh:no_ping'

    Rake::Task[cmd].reenable
    Rake::Task[cmd].invoke

    Rails.logger.info '===== Refresh of sitemap finished ======'
  end
end
