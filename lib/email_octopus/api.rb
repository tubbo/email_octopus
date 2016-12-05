# frozen_string_literal: true
require 'net/http'
require 'json'
require 'email_octopus/api/response'

module EmailOctopus
  # HTTP API gateway to communicate with Email Octopus.
  class API
    HOST = 'emailoctopus.com/api/1.1'
    PORT = 443
    HEADERS = {
      'Content-Type' => 'application/json'
    }.freeze

    def initialize(api_key)
      @http = Net::HTTP.new HOST, PORT, use_ssl: true
      @api_key = api_key
    end

    def get(path)
      Response.new @http.get("#{path}?api_key=#{@api_key}", HEADERS)
    end

    def post(path, body = {})
      body['api_key'] = @api_key
      Response.new @http.post(path, body.to_json, HEADERS)
    end

    def patch(path, body = {})
      body['api_key'] = @api_key
      Response.new @http.patch(path, body.to_json, HEADERS)
    end

    def put(path, body = {})
      body['api_key'] = @api_key
      Response.new @http.put(path, body.to_json, HEADERS)
    end

    def delete(path)
      Response.new @http.delete("#{path}?api_key=#{@api_key}", HEADERS)
    end
  end
end
