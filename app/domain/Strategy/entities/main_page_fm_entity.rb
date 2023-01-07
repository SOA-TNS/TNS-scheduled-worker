# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module GoogleTrend
  module Entity
    class MainPageFmEntity < Dry::Struct
      include Dry.Types

      attribute :avg_per, Strict::String
      attribute :avg_dividend_yield, Strict::String
      attribute :net_buy_probability, Strict::String
      attribute :fear_value, Strict::String
      attribute :fear_greed_index, Strict::String

      def to_attr_hash
        to_hash.except(:id)
      end
    end
  end
end
