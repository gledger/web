require 'ledger/view/base'
require 'date'

module Ledger
  module View
    class Account
      include Base

      attr_reader :account_name, :accounts, :transactions

      def initialize(env, account_name, accounts, transactions)
        @account_name = account_name
        @accounts = accounts
        @transactions = transactions.map { |t|
          t.date = Date.parse(t.date).strftime('%F')
          t
        }

        @template = 'account'

        super(env)
      end
    end
  end
end
