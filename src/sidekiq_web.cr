require "dotenv"
require "kemal"
require "sidekiq/web"
Dotenv.load

ENV["REDIS_PROVIDER"] = ENV["REDIS_PROVIDER"].gsub("\"", "")

# Basic authentication:
#
require "kemal-basic-auth"
basic_auth ENV["SIDEKIQ_USER"], ENV["SIDEKIQ_PASSWORD"]

Kemal.config do |config|
  # To enable SSL termination:
  # ./web --ssl --ssl-key-file your_key_file --ssl-cert-file your_cert_file
  #
  # For more options, including changing the listening port:
  # ./web --help
end

Kemal::Session.config do |config|
  config.secret = ENV["SECRET_TOKEN"]
end

# Exact same configuration for the Client API as above
Sidekiq::Client.default_context = Sidekiq::Client::Context.new

Kemal.run(ENV["PORT"].to_i)
