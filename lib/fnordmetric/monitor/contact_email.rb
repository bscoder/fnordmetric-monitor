require 'remailer'

class FnordMetric::ContactEmail
  def initialize(email)
    @email = email
  end

  def send_message(message_text, opts={})
    if opts[:smtp_connection] then
      connection = opts[:smtp_connection]
      connection_new = false
    else
      connection = Remailer::SMTP::Client.open(opts[:smtp_host] || 'localhost', :debug => STDERR)
      connection_new = true
    end

    connection.send_email(
                          opts[:smtp_from] || 'noreply@localhost',
                          @email,
                          message_text)
    connection.close_when_complete! if connection_new
  end
end
