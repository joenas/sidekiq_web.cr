module ENV
  # NASTY but because of dokku :(
  def self.[](key : String) : String
    fetch(key).gsub("\"", "")
  end
end

require "dotenv"
require "kemal"
require "sidekiq/web"
Dotenv.load

require "kemal-basic-auth"
basic_auth ENV["SIDEKIQ_USER"], ENV["SIDEKIQ_PASSWORD"]

Kemal.config do |config|
  # For more options
  # ./web --help
end

Kemal::Session.config do |config|
  config.secret = ENV["SECRET_TOKEN"]
end

Sidekiq::Client.default_context = Sidekiq::Client::Context.new

Kemal.run(ENV["PORT"].to_i)
