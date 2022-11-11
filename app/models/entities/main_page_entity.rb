# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module GoogleTrend
  module Entity
    class MainPageEntity < Dry::Struct
      include Dry.Types
  
      attribute :query,     Strict::String
      attribute :risk,      Strict::Boolean
      attribute :stock_detail, Entity::SecondPageEntity

      def to_attr_hash
        to_hash.except(:id)
      end
    end
  end
end
