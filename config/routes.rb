require 'rack/router'
require 'ledger/api/client'
require_relative '../app/ledger/controller/root'
require_relative '../app/ledger/controller/account'

module Ledger
  class Routes
    def routes
      Rack::Builder.new do
        api_client = Api::Client.new('http://localhost:8080/')
        root_controller = Controller::Root.new(api_client)
        account_controller = Controller::Account.new(api_client)

        router = Rack::Router.new

        router.get('/' => root_controller.method(:call))
        router.get('/accounts/:name' => account_controller.method(:call))

        run router
      end
    end
  end
end
