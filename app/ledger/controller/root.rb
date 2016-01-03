require 'ledger/view/root'

module Ledger
  module Controller
    class Root
      def initialize(api_client)
        @api_client = api_client
      end

      def call(env)
        accounts = @api_client.accounts
        budgets = @api_client.budgets

        [200, { 'Content-Type' => 'text/html' }, [Ledger::View::Root.new(env, accounts, budgets).render]]
      end
    end
  end
end
