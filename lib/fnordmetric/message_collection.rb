class MessageCollection
  def initialize(opts={})
    @groups = opts[:groups]
    @events_per_contacts = {}
  end

  def add_event(group_ids, event_params)
    message_template_ok = event_params[:template_ok] || "Restore %{title} now is %{current} (normal is [%{min}..%{max}])"
    message_template_error = event_params[:template_error] || "Error %{title} now is %{current} (normal is [%{min}..%{max}])"
    if event_params[:status] then
      message_text =  message_template_ok % event_params
    else
      message_text =  message_template_error % event_params
    end
    self.add_alert(group_ids, message_text)
  end

  def add_alert(group_ids, message_text)
    contacts = group_ids.map{|gid| @groups[gid] rescue []}.flatten.uniq
    contacts.each do |contact|
      @events_per_contacts[contact] ||= []
      @events_per_contacts[contact].push(message_text)
    end
  end

  def send_digest_and_clear
    contacts = @groups.values.flatten.uniq
    contacts.each  do |contact|
      @events_per_contacts[contact] ||= []
      if @events_per_contacts[contact].count >0 then
        message_text = @events_per_contacts[contact].join(",\n")
        send_message(contact, message_text)
        @events_per_contacts[contact]=[]
      end
    end
  end

  def send_message(contact, text)
    FnordMetric.log("To: #{contact}\n #{text}")
    if contact.is_a? FnordMetric::ContactEmail
      contact.send_message(text)
    else
      FnordMetric.log("Unknown contact type %s" % contact.class.name)
    end
  end
end

