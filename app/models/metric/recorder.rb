require 'pathname'

class Metric::Recorder

  def record_all(from = nil, to = nil)

    metrics = all_metrics(from.present?)

    if from.present? && to.nil?
      to = DateTime.now
      from = from.to_date
      to = to.to_date
    end

    metrics.each do |metric|
      if from.present?
        from.upto(to) do |date|
          record_metric metric, date
        end
      else
        record_metric metric
      end
    end
  end


  def record_metric(metric, date = nil)
    if metric.respond_to?('enabled')
      if !metric.enabled
        Rails.logger.info "Skipping disabled metric: #{metric.to_s}"
        return
      end
    end
    ActiveRecord::Base.transaction do
      to_destroy = date
      to_destroy ||= DateTime.now
      Rails.logger.info "Mesuring #{metric.to_s}"
      metric.destroy_all(measured_at: to_destroy.beginning_of_day..to_destroy.end_of_day)
      metric.measure(date).save
    end
  end

  def all_metrics(supporting_past_measurements = false)
    Rails.application.eager_load!
    ActiveRecord::Base.descendants.select{|d|
      d.name.starts_with?('Metric::') &&
      d.name != 'Metric::Metric' &&
      d.respond_to?('measure') && d.respond_to?('measure_current_value') &&
      (supporting_past_measurements == false || d.respond_to?('measure_past_value'))
    }
  end

end
