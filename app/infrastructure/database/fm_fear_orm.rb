# frozen_string_literal: true

require 'sequel'

module GoogleTrend
  module Database
    # Object-Relational Mapper for Members
    class FmFearOrm < Sequel::Model(:fm_fear)
      plugin :timestamps, update_on_create: true
    end
  end
end
