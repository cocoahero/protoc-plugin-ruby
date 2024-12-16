# frozen_string_literal: true

require "test_helper"

module ProtoPlugin
  class ServiceDescriptorTest < Minitest::Test
    def setup
      @file = FileDescriptor.new(
        load_file_fixture("service.proto"),
      )

      @service = @file.services.first
    end

    def test_name
      assert_equal("ArticlesService", @service.name)
    end

    def test_full_name
      assert_equal("ProtoPlugin::Fixtures::ArticlesService", @service.full_name)
    end

    def test_rpc_methods
      assert_equal(2, @service.rpc_methods.count)

      @service.rpc_methods.each do |m|
        assert_instance_of(MethodDescriptor, m)
      end

      assert_equal(
        ["GetArticle", "GetArticles"],
        @service.rpc_methods.map(&:name),
      )
    end
  end
end
