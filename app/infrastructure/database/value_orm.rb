# frozen_string_literal: true

require 'sequel'

module GoogleTrend
  module Database
    # Object-Relational Mapper for Members
    class ValueOrm < Sequel::Model(:gtvalues)
      many_to_one :search_query,
                  class: :'GoogleTrend::Database::StockOrm'

      many_to_many :queries,
                   class: :'GoogleTrend::Database::StockOrm',
                   join_table: :googletrend_values,
                   left_key: :value_id, right_key: :stock_id

      plugin :timestamps, update_on_create: true
    end
  end
end
