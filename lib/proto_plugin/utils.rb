# frozen_string_literal: true

module ProtoPlugin
  # A set of utility functions used by the library.
  module Utils
    class << self
      # Converts string to UpperCamelCase.
      #
      # @param value [String]
      #
      # @return [String]
      def camelize(value)
        string = value.to_s

        if string.match?(/\A[a-z\d]*\z/)
          return string.capitalize
        else
          string = string.sub(/^[a-z\d]*/) do |match|
            match.capitalize! || match
          end
        end

        string.gsub!(%r{(?:_|(/))([a-z\d]*)}i) do
          word = ::Regexp.last_match(2)
          substituted = word.capitalize! || word
          ::Regexp.last_match(1) ? "::#{substituted}" : substituted
        end

        string
      end
    end
  end
end
