# frozen_string_literal: true

module ProtoPlugin
  class EnumDescriptorTest < Minitest::Test
    def setup
      @file = FileDescriptor.new(
        Google::Protobuf::FileDescriptorProto.new(
          package: "my.package.name",
          message_type: [
            Google::Protobuf::DescriptorProto.new(
              name: "RootMessage",
              enum_type: [
                Google::Protobuf::EnumDescriptorProto.new(
                  name: "ChildEnumOne",
                ),
              ],
            ),
          ],
          enum_type: [
            Google::Protobuf::EnumDescriptorProto.new(
              name: "RootEnum",
            ),
          ],
        ),
      )

      @enum = @file.enums.first
    end

    def test_full_name_of_file_enum
      assert_equal("My::Package::Name::RootEnum", @enum.full_name)
    end

    def test_full_name_of_message_enum
      enum = @file.messages.first.enums.first
      assert_equal("My::Package::Name::RootMessage::ChildEnumOne", enum.full_name)
    end
  end
end
