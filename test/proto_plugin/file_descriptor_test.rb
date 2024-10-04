# frozen_string_literal: true

module ProtoPlugin
  class FileDescriptorTest < Minitest::Test
    def test_name
      file = FileDescriptor.new(Google::Protobuf::FileDescriptorProto.new(
        name: "sample.proto",
      ))
      assert_equal("sample.proto", file.name)
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
