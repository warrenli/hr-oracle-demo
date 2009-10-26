# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_oci8_session',
  :secret      => '14bd7aa6d49d5a76185ce40ecd6b578d94c3abfa8dc6ef4708efba497865c282458393420a8f348c514c0ead8b5460be17e9bf29ac713c8323fc4eb8e8b94b0f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
