# frozen_string_literal: true

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
  end
end
