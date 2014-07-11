# Fnordmetric::Monitor

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'fnordmetric-monitor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fnordmetric-monitor

## Usage

    require 'fnordmetric'
    require 'fnordmetric/monitor'
    FnordMetric.namespace :myapp do
        contact_email "foralerts@mydomain.com", :groups => [:admins, :operators]

        ...
        gauge :myevents_per_minute, tick: 1.minute, monitor_min: 10, monitor_max: 60, monitor_recipient: :admins
        ...
    end
    ...

    FnordMetric::Monitor.new


## Contributing

1. Fork it ( http://github.com/bscoder/fnordmetric-monitor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
