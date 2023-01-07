# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module GoogleTrend
  module Entity
    class FmBuySellEntity < Dry::Struct
      include Dry.Types

      attribute :id, Integer.optional
      attribute :stock_name, Strict::String.optional
      attribute :name, Strict::String.optional
      attribute :buy, Strict::String.optional
      attribute :sell, Strict::String.optional

      def to_attr_hash
        to_hash.except(:id)
      end
    end
  end
end
