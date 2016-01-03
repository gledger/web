module Ledger
  module Entity
    class Base
      def self.struct(*args)
        Struct.new(*args) do
          def initialize(from_hash)
            super(*from_hash.values_at(*members))
          end
        end
      end
    end
  end
end
