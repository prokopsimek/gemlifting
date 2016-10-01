class Metric::Transporter
  def initialize
    @client = Metric::Influx.new
  end

  def transport_all
    Metric::Metric.find_each do |metric_entry|
      transport metric_entry
    end
  end

  def transport_pending
    i = 0
    Metric::Metric.where(transported: false).find_each do |metric_entry|
      i = i +1
      transport metric_entry
    end
    return i
  end

  def transport_range(from,to=nil)
    to ||= DateTime.now
    metric.where(:measured_at => from.beginning_of_day..to).find_each do |metric_entry|
      transport metric_entry
    end
  end

  def transport metric
    @client.write_value(metric.type,metric.value,metric.measured_at.to_i)
    metric.transported = true
    metric.save!
  end

end