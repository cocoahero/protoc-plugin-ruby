# frozen_string_literal: true

require_relative "lib/proto_plugin/version"

Gem::Specification.new do |spec|
  spec.name = "proto_plugin"
  spec.version = ProtoPlugin::VERSION
  spec.authors = ["Jonathan Baker"]
  spec.email = ["jonathan@jmb.dev"]
  spec.license = "MIT"

  spec.summary = "Easily build `protoc` plugins in Ruby."

  spec.required_ruby_version = ">= 3.0.0"

  spec.homepage = "https://github.com/cocoahero/proto_plugin"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.files = Dir["lib/**/*", "LICENSE.txt", "README.md"]

  spec.bindir = "exe"
  spec.executables = ["protoc-gen-proto-plugin-demo"]

  spec.require_paths = ["lib"]

  spec.add_dependency("google-protobuf", "~> 4.28")
end
