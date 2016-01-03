require 'ledger/entity'

module Ledger
  module Entity
    Transaction = Base.struct(
      :date,
      :payee,
      :value,
      :running_balance,
    )
  end
end
