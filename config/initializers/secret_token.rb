# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

def application_config
  config = YAML.load_file(Rails.root + 'config/custom_cloud.yml')
  config['application']
rescue Errno::ENOENT
  {}
end

Rails.application.config.secret_token = ENV['SECRET_TOKEN'] || application_config['secret_token']