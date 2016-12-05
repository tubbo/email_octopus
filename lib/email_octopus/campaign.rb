module EmailOctopus
  class Campaign < Model
    attribute :id
    attribute :status
    attribute :name
    attribute :subject
    attribute :to
    attribute :from
    attribute :content
  end
end
