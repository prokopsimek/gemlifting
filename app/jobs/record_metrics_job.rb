
class RecordMetricsJob < BaseJob
  def perform
    Rails.logger.info '---- Record Metrics Job STARTED'
    Metric::Recorder.new.record_all
    Rails.logger.info '---- Record Metrics Job FINISHED'
    TransportMetricsJob.perform_later
  end
end