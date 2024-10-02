# frozen_string_literal: true

require "test_helper"

module ProtoPlugin
  class BaseTest < Minitest::Test
    class TestPlugin < Base
      def supported_features
        [
          Google::Protobuf::Compiler::CodeGeneratorResponse::Feature::FEATURE_PROTO3_OPTIONAL,
          Google::Protobuf::Compiler::CodeGeneratorResponse::Feature::FEATURE_SUPPORTS_EDITIONS,
        ]
      end

      def run
        add_file(path: "test.rb", content: "TestPlugin#generate")
      end
    end

    setup do
      @request = requests(:simple)
      @plugin = TestPlugin.new(request: @request)
    end

    test "adding files" do
      @plugin.add_file(path: "foo.txt", content: "Hello World!")
      @plugin.add_file(path: "bar.txt", content: "Hello World, Again!")

      assert_equal(2, @plugin.response.file.count)

      assert_equal("foo.txt", @plugin.response.file.first.name)
      assert_equal("Hello World!", @plugin.response.file.first.content)

      assert_equal("bar.txt", @plugin.response.file.last.name)
      assert_equal("Hello World, Again!", @plugin.response.file.last.content)
    end

    test "lookup_file" do
      refute_nil(@plugin.lookup_file(name: "test/fixtures/simple/simple.proto"))
      assert_nil(@plugin.lookup_file(name: "test/fixtures/simple/missing.proto"))
    end

    test "parameters" do
      plugin = TestPlugin.new(request: Google::Protobuf::Compiler::CodeGeneratorRequest.new(
        parameter: "foo=bar,bare",
      ))

      expected = {
        "foo" => "bar",
        "bare" => nil,
      }

      assert_equal(expected, plugin.parameters)
    end

    test "parameters when request.parameter is missing" do
      plugin = TestPlugin.new(request: Google::Protobuf::Compiler::CodeGeneratorRequest.new)

      assert_equal({}, plugin.parameters)
    end

    test "supported features" do
      # bitwise or of enum values
      # https://github.com/protocolbuffers/protobuf/blob/v28.0/src/google/protobuf/compiler/plugin.proto#L94-L96
      expected = Google::Protobuf::Compiler::CodeGeneratorResponse::Feature::FEATURE_PROTO3_OPTIONAL |
        Google::Protobuf::Compiler::CodeGeneratorResponse::Feature::FEATURE_SUPPORTS_EDITIONS
      assert_equal(expected, @plugin.response.supported_features)
    end

    test "run! calls run on the plugin" do
      input = StringIO.new
      output = StringIO.new
      response = TestPlugin.run!(input: input, output: output)

      assert_equal(1, response.file.count)
      assert_equal("test.rb", response.file.first.name)
      assert_equal("TestPlugin#generate", response.file.first.content)
    end

    test "run! writes the response to specified output stream" do
      input = StringIO.new
      output = StringIO.new
      response = TestPlugin.run!(input: input, output: output)
      assert_equal(response.to_proto, output.string)
    end
  end
end
