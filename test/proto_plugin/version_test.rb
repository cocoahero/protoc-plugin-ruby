# frozen_string_literal: true

require "test_helper"

module ProtoPlugin
  class VersionTest < Minitest::Test
    test "VERSION" do
      assert ::ProtoPlugin.const_defined?(:VERSION)
    end
  end
end
