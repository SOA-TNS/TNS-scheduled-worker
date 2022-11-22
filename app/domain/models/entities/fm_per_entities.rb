# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module GoogleTrend
  module Entity
    class StockPerEntity < Dry::Struct
      include Dry.Types

      attribute :id, Integer.optional
      attribute :stock_name, Strict::String
      attribute :time, Strict::String
      attribute :per, Strict::String
      attribute :pbr, Strict::String

      def to_attr_hash
        to_hash.except(:id)
      end
    end
  end
end
