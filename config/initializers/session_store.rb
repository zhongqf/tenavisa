# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tenavisa_session',
  :secret      => '7d77467af1cbff12a453c563284fec2556bf6c6948a5599cddc74d9a378c257e53b77d0d63e1d4890f341f58b3c0c6f3212449b95613995386b591d9c2347fd1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
