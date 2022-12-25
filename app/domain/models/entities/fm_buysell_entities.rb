# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module GoogleTrend
  module Entity
    class FmBuySellEntity < Dry::Struct
      include Dry.Types

      attribute :id, Integer.optional
      attribute :stock_name, Strict::String
      attribute :name, Strict::String
      attribute :buy, Strict::String
      attribute :sell, Strict::String

      def to_attr_hash
        to_hash.except(:id)
      end
    end
  end
end
