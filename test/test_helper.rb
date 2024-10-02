# frozen_string_literal: true

require "minitest/autorun"
require "minitest/declarative"
require "proto_plugin"

def requests(name)
  file = File.join("test", "fixtures", "#{name}.pb")

  unless File.exist?(file)
    raise "fixture not found - #{file}"
  end

  Google::Protobuf::Compiler::CodeGeneratorRequest.decode(
    File.read(file),
  )
end
