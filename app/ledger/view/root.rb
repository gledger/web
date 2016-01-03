require 'ledger/view/base'

module Ledger
  module View
    class Root
      include Base

      attr_reader :accounts, :budgets

      def initialize(env, accounts, budgets)
        @accounts = accounts
        @budgets = budgets

        @template = 'root'

        super(env)
      end
    end
  end
end
