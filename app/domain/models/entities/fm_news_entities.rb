# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module GoogleTrend
  module Entity
    class StoctNewsEntity < Dry::Struct
      include Dry.Types

      attribute :id, Integer.optional
      attribute :stock_name, Strict::String
      attribute :date, Strict::String
      attribute :link, Strict::String
      attribute :source, Strict::String
      attribute :title, Strict::String

      def to_attr_hash
        to_hash.except(:id)
      end
    end
  end
end
