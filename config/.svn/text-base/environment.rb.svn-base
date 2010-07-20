RAILS_GEM_VERSION = '2.1.1' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_jobmia_session',
    :secret      => '21d0ab92dsfdsff2d832797a5f64083b59cbbf'
  }

  # Activate observers that should always be running
  config.active_record.observers = :user_observer

  config.time_zone = "Chennai"
  
  config.load_paths << File.join(RAILS_ROOT, %w[app sweepers])
  
  config.cache_store = :file_store, "#{RAILS_ROOT}/tmp/cache"

end

require 'ruport'