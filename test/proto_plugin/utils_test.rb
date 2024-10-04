# frozen_string_literal: true

module ProtoPlugin
  class UtilsTest < Minitest::Test
    def test_camelize
      cases = {
        "foo" => "Foo",
        "active_support" => "ActiveSupport",
        "active_support/foo" => "ActiveSupport::Foo",
      }
      cases.each do |input, expected|
        assert_equal(expected, ProtoPlugin::Utils.camelize(input))
      end
    end
  end
end
