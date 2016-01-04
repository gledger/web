require 'multi_json'
require 'typhoeus'

require 'ledger/entity/transaction'

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

      def account_transactions(name)
        response = Typhoeus.get("#{@base_url}transactions?account=#{name}")

        if response.code != 200
          raise Error.new(response.inspect)
        end

        MultiJson.load(response.body).map { |row|
          Entity::Transaction.new(
            :date => row['date'],
            :payee => row['payee'],
            :value => row['value'],
            :running_balance => row['running_balance'],
          )
        }
      end

      def create_transaction(data_hash)
        account_count = 0
        accounts = []
        data_hash['add_transaction_account'].each do |row|
          accounts << {
            :name => row,
            :amount => data_hash['add_transaction_value'][account_count],
          }

          account_count+=1
        end

        json_data = MultiJson.dump({
          :date => data_hash['date'],
          :payee => data_hash['payee'],
          :accounts => accounts,
        })

        Typhoeus.post(
          "#{@base_url}transactions",
          :body => json_data,
          :headers => {'Content-Type' => 'application/json'},
        )
      end

      class Error < StandardError; end
    end
  end
end
