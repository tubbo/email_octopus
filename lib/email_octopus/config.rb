# frozen_string_literal: true

module EmailOctopus
  # Configuration for the gem.
  class Config
    def initialize
      @data = { api_key: nil }
    end

    def method_missing(method, *arguments)
      return super unless respond_to_missing? method
      return self[method] unless setter? method
      key = key_for(method)
      self[key] = *arguments
    end

    def key?(method)
      @data.key? method.to_s
    end

    def [](key)
      @data[key.to_s]
    end

    def []=(key, value)
      @data[key.to_s] = value
    end

    def respond_to_missing?(method, include_private = true)
      true #key?(method) || super
    end

    private

    def key_for(method)
      method.to_s.gsub(/\=\Z/, '')
    end

    def setter?(method)
      key_for(method) != method.to_s
    end
  end
end
