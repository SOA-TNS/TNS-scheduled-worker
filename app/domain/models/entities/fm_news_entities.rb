# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module GoogleTrend
  module Entity
    class FmNewsEntity < Dry::Struct
      include Dry.Types

      attribute :id, Integer.optional
      attribute :stock_name, Strict::String.optional
      attribute :date, Strict::String.optional
      attribute :link, Strict::String.optional
      attribute :source, Strict::String.optional
      attribute :title, Strict::String.optional

      def to_attr_hash
        to_hash.except(:id)
      end
    end
  end
end
