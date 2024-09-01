# frozen_string_literal: true

module Minitest
  module Declarative
    def test(name, &block)
      test_name = "test_#{name.gsub(/\s+/, "_")}".to_sym
      defined = method_defined?(test_name)
      raise "#{test_name} is already defined in #{self}" if defined

      if block_given?
        define_method(test_name, &block)
      else
        define_method(test_name) do
          flunk("No implementation provided for #{name}")
        end
      end
    end

    def setup(&block)
      if block_given?
        define_method(:setup, &block)
      else
        define_method(:setup) do
          flunk("No implementation provided for #{name}")
        end
      end
    end

    def teardown(&block)
      if block_given?
        define_method(:teardown, &block)
      else
        define_method(:teardown) do
          flunk("No implementation provided for #{name}")
        end
      end
    end
  end
end

Minitest::Test.extend(Minitest::Declarative)
