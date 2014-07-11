require 'remailer'

class FnordMetric::ContactEmail
  def initialize(email)
    @email = email
  end

  def send_message(message_text, opts={})
    connection = opts[:smtp_connection] ||
      Remailer::Connection.open(opts[:smtp_host] || 'localhost', :debug => STDERR)

    connection.send_email(
                            opts[:smtp_from] || 'noreply@localhost',
                            @email,
                            message_text)
  end
end
