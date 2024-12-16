# frozen_string_literal: true

require "test_helper"

module ProtoPlugin
  class FileDescriptorTest < Minitest::Test
    def test_name
      file = FileDescriptor.new(Google::Protobuf::FileDescriptorProto.new(
        name: "sample.proto",
      ))
      assert_equal("sample.proto", file.name)
    end

    def test_enums
      file = FileDescriptor.new(
        Google::Protobuf::FileDescriptorProto.new(
          package: "my.package.name", enum_type: [
            Google::Protobuf::EnumDescriptorProto.new(
              name: "RootEnumOne",
            ),
            Google::Protobuf::EnumDescriptorProto.new(
              name: "RootEnumTwo",
            ),
          ]
        ),
      )

      assert_equal(2, file.enums.count)

      enum_one = file.enums[0]
      assert_instance_of(EnumDescriptor, enum_one)

      enum_two = file.enums[1]
      assert_instance_of(EnumDescriptor, enum_two)
    end

    def test_messages
      file = FileDescriptor.new(
        Google::Protobuf::FileDescriptorProto.new(
          package: "my.package.name", message_type: [
            Google::Protobuf::DescriptorProto.new(
              name: "RootMessageOne",
            ),
            Google::Protobuf::DescriptorProto.new(
              name: "RootMessageTwo",
            ),
          ]
        ),
      )
      assert_equal(2, file.messages.count)

      message_one = file.messages[0]
      assert_instance_of(MessageDescriptor, message_one)

      message_two = file.messages[1]
      assert_instance_of(MessageDescriptor, message_two)
    end

    def test_services
      file = FileDescriptor.new(
        Google::Protobuf::FileDescriptorProto.new(
          package: "my.package.name", service: [
            Google::Protobuf::ServiceDescriptorProto.new(
              name: "ServiceOne",
            ),
            Google::Protobuf::ServiceDescriptorProto.new(
              name: "ServiceTwo",
            ),
          ]
        ),
      )
      assert_equal(2, file.services.count)

      service_one = file.services[0]
      assert_instance_of(ServiceDescriptor, service_one)

      service_two = file.services[1]
      assert_instance_of(ServiceDescriptor, service_two)
    end

    def test_namespace_without_package
      file = FileDescriptor.new(Google::Protobuf::FileDescriptorProto.new(
        name: "sample.proto",
      ))
      assert_equal("", file.namespace)
    end

    def test_namespace_with_package
      file = FileDescriptor.new(Google::Protobuf::FileDescriptorProto.new(
        name: "sample.proto", package: "my.package.name",
      ))
      assert_equal("My::Package::Name", file.namespace)
    end

    def test_namespace_with_ruby_package
      file = FileDescriptor.new(Google::Protobuf::FileDescriptorProto.new(
        name: "sample.proto", options: Google::Protobuf::FileOptions.new(
          ruby_package: "My::Ruby::Namespace",
        )
      ))
      assert_equal("My::Ruby::Namespace", file.namespace)
    end

    def test_namespace_with_package_and_ruby_package
      file = FileDescriptor.new(Google::Protobuf::FileDescriptorProto.new(
        name: "sample.proto", package: "my.package.name", options: Google::Protobuf::FileOptions.new(
          ruby_package: "My::Ruby::Namespace",
        )
      ))
      assert_equal("My::Ruby::Namespace", file.namespace)
    end

    def test_namespace_with_split_option
      file = FileDescriptor.new(Google::Protobuf::FileDescriptorProto.new(
        name: "sample.proto", package: "my.package.name",
      ))
      assert_equal(["My", "Package", "Name"], file.namespace(split: true))
    end
  end
end
