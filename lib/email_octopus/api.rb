# frozen_string_literal: true
require 'httparty'
require 'json'
require 'email_octopus/api/response'

module EmailOctopus
  # HTTP API gateway to communicate with Email Octopus.
  class API
    include HTTParty

    base_uri 'https://emailoctopus.com/api/1.1'
    format :json
    headers "Content-Type" => 'application/json'

    def initialize(api_key)
      @api_key = api_key
    end

    def get(path, url_params)
      url_params['api_key'] = @api_key
      Response.new self.class.get(path, query: url_params)
    end

    def post(path, body = {})
      body['api_key'] = @api_key
      Response.new self.class.post(path, body: body)
    end

    def patch(path, body = {})
      body['api_key'] = @api_key
      Response.new self.class.patch(path, body: body)
    end

    def put(path, body = {})
      body['api_key'] = @api_key
      Response.new self.class.put(path, body: body)
    end

    def delete(path, url_params)
      url_params['api_key'] = @api_key
      Response.new self.class.get(path, query: url_params)
    end
  end
end
