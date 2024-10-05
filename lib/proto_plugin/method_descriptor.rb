# frozen_string_literal: true

require "delegate"

module ProtoPlugin
  # A wrapper class around `Google::Protobuf::MethodDescriptorProto`
  # which provides helpers and more idiomatic Ruby access patterns.
  #
  # Any method not defined directly is delegated to the descriptor the wrapper was initialized with.
  #
  # @see https://github.com/protocolbuffers/protobuf/blob/v28.2/src/google/protobuf/descriptor.proto#L381
  class MethodDescriptor < SimpleDelegator
    # @return [Google::Protobuf::MethodDescriptorProto]
    attr_reader :descriptor

    # The service this method was defined in.
    #
    # @return [ServiceDescriptor]
    attr_reader :service

    # @param descriptor [Google::Protobuf::MethodDescriptorProto]
    # @param service [ServiceDescriptor] The service this method was defined in.
    def initialize(descriptor, service)
      super(descriptor)
      @descriptor = descriptor
      @service = service
    end
  end
end
