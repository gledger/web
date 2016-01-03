$:.unshift File.dirname(__FILE__) + '/lib'
$:.unshift File.dirname(__FILE__) + '/app'

require File.expand_path('../config/init', __FILE__)

run Ledger::Routes.new.routes
