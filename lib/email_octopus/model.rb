# frozen_string_literal: true
require 'email_octopus/api'

module EmailOctopus
  # Common code for model objects.
  class Model
    attr_reader :attributes

    def initialize(params = {})
      @attributes = params
      @api = API.new(EmailOctopus.config.api_key)
    end

    def self.create(params = {})
      new(params).tap(&:save)
    end

    def self.find(id)
      new(id: id).tap(&:persisted?)
    end

    def self.all
      Query.new self
    end

    def self.limit(num)
      all.limit(num)
    end

    def self.page(num)
      all.page(num)
    end

    def self.resource_name
      name.downcase + 's'
    end

    def self.attribute(name)
      define_method name do
        attributes[name.to_s]
      end

      define_method "#{name}=" do |value|
        attributes[name.to_s] = value
      end
    end

    def persisted?
      id.present? && reload!
    end

    def save
      create || update
    end

    def as_json
      attributes
    end

    def to_json
      as_json.to_json
    end

    def destroy
      @api.delete(base_path).success?
    end

    def reload!
      @attributes = @api.get(path).body
    end

    private

    def create
      return true unless new_record?
      @api.post(base_url, to_json).success?
    end

    def update
      return true unless persisted?
      @api.patch(url, to_json).success?
    end

    def base_path
      "/#{self.class.resource_name}"
    end

    def path
      "#{base_path}/#{id}"
    end
  end
end
