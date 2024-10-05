# frozen_string_literal: true

module ProtoPlugin
  class ServiceDescriptorTest < Minitest::Test
    def setup
      @file = FileDescriptor.new(
        Google::Protobuf::FileDescriptorProto.new(
          package: "my.package.name",
          service: [
            Google::Protobuf::ServiceDescriptorProto.new(
              name: "MyService",
            ),
          ],
        ),
      )

      @service = @file.services.first
    end

    def test_name
      assert_equal("MyService", @service.name)
    end

    def test_full_name
      assert_equal("My::Package::Name::MyService", @service.full_name)
    end
  end
end
