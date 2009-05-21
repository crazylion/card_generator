# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_card_generator_session',
  :secret      => 'b9b88921145f5d9fede2e28dee13778ac4fa647fb868e5542dd84bf3754a7372a0661a03636d232c097bbb347a188461cede46bf1cba022bc8cd7ff469c8cf96'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
