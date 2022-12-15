# frozen_string_literal: true

require 'sequel'

module GoogleTrend
  module Database
    # Object-Relational Mapper for Members
    class FmBuysellOrm < Sequel::Model(:fm_buysell)
      many_to_one :stock,
      class: :'GoogleTrend::Database::FmValueOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end
