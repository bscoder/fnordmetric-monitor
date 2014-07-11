module FnordMetric::GaugeMonitor
  def monitoring?
    @opts[:monitor_min] || @opts[:monitor_max]
  end

  def monitor_isok?
    _prev_value = prev_value
    !(@opts[:monitor_min] && @opts[:monitor_min] > _prev_value ||
      @opts[:monitor_max] && @opts[:monitor_max] < _prev_value)
  end

  def monitor_status_save
    @prev_monitor_status = monitor_isok?
  end

  def monitor_status_changed?
    @prev_monitor_status = true if @prev_monitor_status.nil?
    monitor_isok? != @prev_monitor_status
  end

  def prev_value
    value_at(Time.new.to_i - tick).to_i   
  end

  def monitor_check(message_collection)
    return unless monitoring? && monitor_status_changed?
    monitor_notification(message_collection)
    monitor_status_save
  end

  def monitor_notification(message_collection)
    FnordMetric.log("EVENT #{name} #{prev_value}")
    if @opts[:monitor_recipient] then
      if @opts[:monitor_recipient].is_a? Symbol then
        recipients = [@opts[:monitor_recipient]]
      elsif @opts[:monitor_recipient].is_a? Array 
        recipients = @opts[:monitor_recipient]
      end
      message_collection.add_event recipients, {
        title: title,
        min: @opts[:monitor_min],
        max: @opts[:monitor_max],
        current: prev_value,
        period_start: tick_at(Time.new.to_i - tick),
        period_end: tick_at(Time.new.to_i - tick) + tick
      }
    end
  end
end
