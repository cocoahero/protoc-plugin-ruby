# Proto::Plugin

[![Gem Version](https://badge.fury.io/rb/proto_plugin.svg)](https://badge.fury.io/rb/proto_plugin)

## Installation

```bash
gem install proto_plugin
```

## Usage

Creating a `protoc` plugin is as simple as creating a new executable script. The name of the file must follow the format `protoc-gen-[plugin-name]`.

As an example, the below file could be named `protoc-gen-mycoolplugin`.

```ruby
#! /usr/bin/env ruby

require "proto_plugin"

class MyCoolPlugin < ProtoPlugin::Base
  def run
    request.file_to_generate.each do |f|
      name = File.basename(f, ".proto")

      add_file(name: "#{name}.txt", content: <<~TXT)
        This file was generated from #{name}.proto!
      TXT
    end
  end
end

MyCoolPlugin.run!
```

To invoke the plugin, first make sure you have `protoc` installed. Then in a terminal, run:

```bash
protoc --plugin=path/to/protoc-gen-mycoolplugin --mycoolplugin_out=. input.proto
```

If the executable script is in your `$PATH`, for example installed via a gem, you can omit the `--plugin` argument.

```bash
protoc --mycoolplugin_out=. input.proto
```

See [`exe/protoc-gen-proto-plugin-demo`](./exe/protoc-gen-proto-plugin-demo) in this repo as another example of a plugin. Since it should be in your `$PATH` (you did install this gem right?) you can invoke it with:

```bash
protoc --proto-plugin-demo_out=. input.proto
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cocoahero/proto_plugin.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
