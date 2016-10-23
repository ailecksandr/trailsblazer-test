ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'minitest/rails/capybara'
require 'trailblazer/rails/test/integration'
require 'support/database_cleaner'
require 'support/cell_helper'
