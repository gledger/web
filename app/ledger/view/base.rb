require 'rack/csrf'
require 'erubis'

module Ledger
  module View
    module Base
      attr_reader :template

      def initialize(env)
        @env = env
      end

      def render
        render_layout
      end

      def body
        ::Erubis::EscapedEruby.new(File.read(filename)).result binding
      end

      def csrf
        ::Rack::Csrf.metatag(env)
      end

      private

      attr_accessor :env

      def render_layout
        layout = File.read(File.dirname(__FILE__) + "/../templates/layout.erb")
        ::Erubis::EscapedEruby.new(layout).result(binding)
      end

      def filename
        File.dirname(__FILE__) + "/../templates/#{template}.erb"
      end
    end
  end
end
