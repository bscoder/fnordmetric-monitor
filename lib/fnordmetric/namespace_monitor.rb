require 'fnordmetric/monitor/contact_email.rb'

module FnordMetric::NamespaceMonitor
  def contact_email(email, opts={})
    @monitor_contacts ||= {}
    groups = opts[:groups] || [:all]
    groups.each do |group|
      @monitor_contacts[group] ||= []
      @monitor_contacts[group].push(FnordMetric::ContactEmail.new(email))
    end
  end
  def monitor_contacts
    @monitor_contacts ||= {}
  end
end
