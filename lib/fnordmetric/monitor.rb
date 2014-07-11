require "fnordmetric/gauge_monitor"
require 'fnordmetric/message_collection'
require 'fnordmetric/namespace_monitor'

class FnordMetric::Namespace
  include  FnordMetric::NamespaceMonitor
end

class FnordMetric::Gauge
  include FnordMetric::GaugeMonitor
end

class FnordMetric::Monitor
  def initialize(opts = {})
    @namespaces = FnordMetric.namespaces
    @opts = FnordMetric.options(opts)
    @message_collections = {}
    @namespaces.each do |ns_id, ns|
      @message_collections[ns_id] = MessageCollection.new(groups: ns.monitor_contacts)
    end
    EM.next_tick do configure; end
  end

  def configure
    EM.add_periodic_timer(1) do
      self.monitor_loop
    end
  end

  def monitor_loop
    @namespaces.each do |ns_id, ns|
      ns.gauges.each do |gname, g|
        if g.monitoring?
          g.monitor_check(@message_collections[ns_id])
        end
      end
      @message_collections[ns_id].send_digest_and_clear
    end
  end

  def initialized
    FnordMetric.log("checker started")
    EM.next_tick(&method(:tick))
  end
end

