require 'rack/request'

module Ledger
  module Controller
    class TransactionCreate
      def initialize(api_client)
        @api_client = api_client
      end

      def call(env)
        req = Rack::Request.new(env)

        @api_client.create_transaction(req.POST)

        [302, { 'Location' => req.referrer }, []]
      end
    end
  end
end
