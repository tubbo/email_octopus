module EmailOctopus
  class API
    class Error < StandardError
      # Thrown when user cannot access resource.
      class Unauthorized < Error
      end
    end
  end
end
