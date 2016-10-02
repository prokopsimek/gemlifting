class TransportMetricsJob < SidekiqJobBase
  def perform
    Rails.logger.info '==== Transport Metrics Job STARTED ===='
    count = Metric::Transporter.new.transport_pending
    Rails.logger.info "==== Transport Metrics Job FINISHED - Transported #{count} metrics. ===="
  end
end
