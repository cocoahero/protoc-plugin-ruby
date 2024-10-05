# frozen_string_literal: true

require "debug"
require "minitest/autorun"
require "proto_plugin"

def load_request_fixture
  fixture = File.join("test", "fixtures", "blog.cgr")

  unless File.exist?(fixture)
    raise "fixture not found - #{fixture}"
  end

  Google::Protobuf::Compiler::CodeGeneratorRequest.decode(
    File.read(fixture),
  )
end

def load_file_fixture(name)
  fixture = File.join("test", "fixtures", "blog.fds")

  unless File.exist?(fixture)
    raise "fixture not found - #{fixture}"
  end

  files = Google::Protobuf::FileDescriptorSet.decode(
    File.read(fixture),
  ).file

  unless (result = files.find { |f| f.name == name })
    raise "file not found - #{name}"
  end

  result
end
