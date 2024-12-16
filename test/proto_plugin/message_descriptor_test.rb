# frozen_string_literal: true

require "test_helper"

module ProtoPlugin
  class MessageDescriptorTest < Minitest::Test
    def setup
      @file = FileDescriptor.new(
        Google::Protobuf::FileDescriptorProto.new(
          package: "my.package.name",
          message_type: [
            Google::Protobuf::DescriptorProto.new(
              name: "RootMessage",
              nested_type: [
                Google::Protobuf::DescriptorProto.new(
                  name: "ChildMessageOne",
                ),
                Google::Protobuf::DescriptorProto.new(
                  name: "ChildMessageTwo",
                ),
              ],
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

      @message = @file.messages.first
    end

    def test_name
      assert_equal("RootMessage", @message.name)
    end

    def test_enums
      assert_equal(1, @message.enums.count)
      assert_equal("ChildEnumOne", @message.enums.first.name)
    end

    def test_messages
      assert_equal(2, @message.messages.count)

      child_one = @message.messages[0]
      child_two = @message.messages[1]

      assert_equal("ChildMessageOne", child_one.name)
      assert_equal(@message, child_one.parent)

      assert_equal("ChildMessageTwo", child_two.name)
      assert_equal(@message, child_two.parent)
    end

    def test_full_name
      child_one = @message.messages[0]
      child_two = @message.messages[1]

      assert_equal("My::Package::Name::RootMessage", @message.full_name)
      assert_equal("My::Package::Name::RootMessage::ChildMessageOne", child_one.full_name)
      assert_equal("My::Package::Name::RootMessage::ChildMessageTwo", child_two.full_name)
    end
  end
end
