gem 'rspec'

require "william-client/config"
William.config.william_api_url = "http://localhost:3000"
William.config.app_name = "Test"
William.config.app_token = "1234"

require 'william-client'

require 'rspec/autorun'
require 'webmock/rspec'
require 'json'

def stub_request_factory(file, url, method = :get)
  response = File.read(file)
  stub_request(method, url).
    with(headers: {'Content-Type'=>'application/json'}).
    to_return(status: 200, body: response, headers: {content_type: 'application/json'})
  response
end
