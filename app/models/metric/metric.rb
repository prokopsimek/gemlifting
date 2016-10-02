class Metric::Metric < ActiveRecord::Base
  default_scope { order(:measured_at) }

  def self.measure(date=nil)

    if date.present?
      value = self.measure_past_value(date)
    else
      value = self.measure_current_value
      date = DateTime.now
    end
    object = self.new
    object.value = value
    object.measured_at = date
    object
  end



end
