# frozen_string_literal: true

require "test_helper"

module ProtoPlugin
  class MethodDescriptorTest < Minitest::Test
    def setup
      @file = FileDescriptor.new(
        load_file_fixture("service.proto"),
      )

      @service = @file.services.first
      @methods = @service.rpc_methods.each_with_object({}) do |rpc, hash|
        hash[rpc.name] = rpc
      end
    end

    def test_input
      get_article = @methods["GetArticle"]

      refute_nil(get_article)

      assert_equal(".proto_plugin.fixtures.GetArticleRequest", get_article.input_type)
    end

    def test_output
      get_article = @methods["GetArticle"]

      refute_nil(get_article)

      assert_equal(".proto_plugin.fixtures.GetArticleResponse", get_article.output_type)
    end

    def test_streaming
      article_stream = @methods["ArticleStream"]

      refute_nil(article_stream)

      refute(article_stream.unary?)
      refute(article_stream.client_streaming?)
      assert(article_stream.server_streaming?)
      refute(article_stream.bidirectional_streaming?)
    end
  end
end
