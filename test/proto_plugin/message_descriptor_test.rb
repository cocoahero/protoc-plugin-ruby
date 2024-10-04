# frozen_string_literal: true

module ProtoPlugin
  class MessageDescriptorTest < Minitest::Test
    def test_messages
      descriptor = Google::Protobuf::DescriptorProto.new(
        name: "RootMessage", nested_type: [
          Google::Protobuf::DescriptorProto.new(
            name: "ChildMessageOne",
          ),
          Google::Protobuf::DescriptorProto.new(
            name: "ChildMessageTwo",
          ),
        ]
      )

      message = MessageDescriptor.new(descriptor, nil)

      assert_equal(2, message.messages.count)

      child_one = message.messages[0]
      child_two = message.messages[1]

      assert_equal("ChildMessageOne", child_one.name)
      assert_equal(message, child_one.parent)

      assert_equal("ChildMessageTwo", child_two.name)
      assert_equal(message, child_two.parent)
    end
  end
end
