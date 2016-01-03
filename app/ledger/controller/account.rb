require 'ledger/view/account'

module Ledger
  module Controller
    class Account
      def initialize(api_client)
        @api_client = api_client
      end

      def call(env)
        transactions = @api_client.account_transactions(env['rack.route_params'][:name])
        accounts = @api_client.accounts

        [200, { 'Content-Type' => 'text/html' }, [Ledger::View::Account.new(env, env['rack.route_params'][:name], accounts, transactions).render]]
      end
    end
  end
end
