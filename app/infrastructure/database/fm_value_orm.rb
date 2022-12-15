# frozen_string_literal: true

require 'sequel'

module GoogleTrend
  module Database
    # Object-Relational Mapper for Members
    class FmValueOrm < Sequel::Model(:fmvalues)
      one_to_many :stock_name,
                  class: :'GoogleTrend::Database::FmFearOrm',
                  key: :fmvalues_id

      one_to_many :stock_name,
                  class: :'GoogleTrend::Database::FmNewsOrm',
                  key: :fmvalues_id

      one_to_many :stock_name,
                  class: :'GoogleTrend::Database::FmPerOrm',
                  key: :fmvalues_id

      plugin :timestamps, update_on_create: true
    end
  end
end
