# frozen_string_literal: true

require "test_helper"

module ProtoPlugin
  class VersionTest < Minitest::Test
    def test_version
      assert(::ProtoPlugin.const_defined?(:VERSION))
    end
  end
end
