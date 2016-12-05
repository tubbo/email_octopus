# frozen_string_literal: true
require 'email_octopus/contact'

module EmailOctopus
  # Mailing list.
  class List < Model
    attribute :id
    attribute :name

    def contacts
      Contact.where list_id: id
    end

    def create_contact(params = {})
      Contact.create params.merge(list_id: id)
    end
  end
end
