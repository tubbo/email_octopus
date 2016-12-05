# frozen_string_literal: true

module EmailOctopus
  class API
    class Error < StandardError
      # Thrown when resource cannot be found.
      class NotFound < Error
      end
    end
  end
end
