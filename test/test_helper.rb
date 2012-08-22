gem 'rspec'

require "william-client/config"
William.config.william_api_url = "http://localhost:3000"
William.config.app_name = "Test"
William.config.app_token = "1234"

require 'william-client'

require 'rspec/autorun'
require 'webmock/rspec'
require 'json'
