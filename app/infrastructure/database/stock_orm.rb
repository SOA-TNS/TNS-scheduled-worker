# frozen_string_literal: true

require 'sequel'

module GoogleTrend
  module Database
    # Object-Relational Mapper for Members
    class StockOrm < Sequel::Model(:stock)
      one_to_many :history_trend,
                  class: :'GoogleTrend::Database::ValueOrm',
                  key: :query

      many_to_many :trends,
                   class: :'GoogleTrend::Database::ValueOrm',
                   join_table: :googletrend_values,
                   left_key: :stock_id, right_key: :value_id

      plugin :timestamps, update_on_create: true
    end
  end
end