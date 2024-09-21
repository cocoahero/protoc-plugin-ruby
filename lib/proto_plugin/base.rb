# frozen_string_literal: true

require "google/protobuf"
require "google/protobuf/plugin_pb"

module ProtoPlugin
  class Base
    class << self
      def run!(input: $stdin, output: $stdout)
        request = Google::Protobuf::Compiler::CodeGeneratorRequest.decode(
          input.read,
        )

        plugin = new(request: request)
        plugin.run

        result = plugin.response
        output.write(result.to_proto)
        result
      end
    end

    attr_reader :request

    attr_reader :response

    def initialize(request:)
      @request = request
      @response = Google::Protobuf::Compiler::CodeGeneratorResponse.new(
        supported_features: supported_features.reduce(&:|),
      )
    end

    def supported_features
      [Google::Protobuf::Compiler::CodeGeneratorResponse::Feature::FEATURE_NONE]
    end

    def add_file(name:, content:)
      @response.file << Google::Protobuf::Compiler::CodeGeneratorResponse::File.new(
        name: name, content: content,
      )
    end

    def run
    end
  end
end
