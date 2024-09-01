# frozen_string_literal: true

require "bundler/gem_tasks"
require "rubocop/rake_task"
require "minitest/test_task"

RuboCop::RakeTask.new

Minitest::TestTask.create(:test) do |t|
  t.libs << "lib"
  t.libs << "test"
  t.test_globs = ["test/**/*_test.rb"]
end

task default: [:test, :rubocop]
