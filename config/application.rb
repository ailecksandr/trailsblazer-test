require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module TrailblazerTest
  class Application < Rails::Application
  end
end