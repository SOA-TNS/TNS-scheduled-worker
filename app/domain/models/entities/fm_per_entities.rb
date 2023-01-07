# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module GoogleTrend
  module Entity
    class FmPerEntity < Dry::Struct
      include Dry.Types

      attribute :id, Integer.optional
      attribute :stock_name, Strict::String.optional
      attribute :time, Strict::String.optional
      attribute :div_yield, Strict::String.optional
      attribute :per, Strict::String.optional
      attribute :pbr, Strict::String.optional

      def to_attr_hash
        to_hash.except(:id)
      end
    end
  end
end
