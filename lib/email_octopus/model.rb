# frozen_string_literal: true
require 'email_octopus/api'
require 'active_model/naming'

module EmailOctopus
  # Common code for model objects.
  class Model
    extend ActiveModel::Naming

    # @!attribute attributes [r]
    #   @return [Hash] Attributes related to this model.
    attr_reader :attributes

    # @param params [Hash] Initial attributes for this model.
    def initialize(params = {})
      @attributes = params
      @api = API.new(EmailOctopus.config.api_key)
    end

    # Instantiate a new resource and immediately persist it on the API.
    #
    # @param params [Hash] Initial attributes to save.
    def self.create(params = {})
      new(params).tap(&:save)
    end

    # Find a resource by its given ID.
    #
    # @param id [String] ID provided by EmailOctopus for this resource.
    def self.find(id)
      new(id: id).tap(&:persisted?)
    end

    # Start a new query on a group of model resources.
    #
    # @return [Query] for this model class.
    def self.all
      Query.new self
    end

    # Delegate all class method calls that aren't defined on the model
    # class to its +Query+.
    #
    # @param method [Symbol] Name of the method to call.
    # @param arguments [Array] Arguments to pass to the method.
    # @throws [NoMethodError] when method not defined on +all+
    # @return [Query]
    def self.method_missing(method, *arguments)
      return super unless respond_to? method
      all.public_send method, *arguments
    end

    # Define a new attribute method on the model that reads from the
    # +attributes+ hash.
    #
    # @param name [Symbol] Name of the attribute
    def self.attribute(name)
      define_method name do
        attributes[name.to_s]
      end

      define_method "#{name}=" do |value|
        attributes[name.to_s] = value
      end
    end

    # 
    def persisted?
      id.present? && reload!
    end

    # Run validations and persist to the database.
    def save
      valid? && persist!
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

    def persist!
      create || update
    end

    def base_path
      "/#{model_name.collection}"
    end

    def path
      "#{base_path}/#{id}"
    end
  end
end
