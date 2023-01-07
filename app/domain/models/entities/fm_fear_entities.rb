# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module GoogleTrend
  module Entity
    class FmFearEntity < Dry::Struct
      include Dry.Types

      attribute :id, Integer.optional
      attribute :time, Strict::String.optional
      attribute :fear_greed, Strict::String
      attribute :fear_greed_emotion, Strict::String

      def to_attr_hash
        to_hash.except(:id)
      end
    end
  end
end
