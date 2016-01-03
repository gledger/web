module Ledger
  module Api
    class Client
      def initialize(base_url)
        @base_url = base_url
      end

      def accounts
        response = Typhoeus.get(@base_url)

        if response.code != 200
          raise Error.new(response.inspect)
        end

        MultiJson.load(response.body)['accounts']
      end

      def budgets
        response = Typhoeus.get(@base_url)

        if response.code != 200
          raise Error.new(response.inspect)
        end

        MultiJson.load(response.body)['budgets']
      end

      class Error < StandardError; end
    end
  end
end
