# frozen_string_literal: true

require "delegate"

module ProtoPlugin
  # A wrapper class around `Google::Protobuf::ServiceDescriptorProto`
  # which provides helpers and more idiomatic Ruby access patterns.
  #
  # Any method not defined directly is delegated to the descriptor the wrapper was initialized with.
  #
  # @see https://github.com/protocolbuffers/protobuf/blob/v28.2/src/google/protobuf/descriptor.proto#L373
  class ServiceDescriptor < SimpleDelegator
    # @return [Google::Protobuf::ServiceDescriptorProto]
    attr_reader :descriptor

    # The file this service was defined within.
    #
    # @return [FileDescriptor]
    attr_reader :parent

    # @param descriptor [Google::Protobuf::ServiceDescriptorProto]
    # @param parent [FileDescriptor] The file this service was defined within.
    def initialize(descriptor, parent)
      super(descriptor)
      @descriptor = descriptor
      @parent = parent
    end

    # The full name of the service, including parent namespace.
    #
    # @example
    #   "My::Ruby::Package::ServiceName"
    #
    # @return [String]
    def full_name
      @full_name ||= "#{parent.namespace}::#{name}"
    end
  end
end
