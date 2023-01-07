# frozen_string_literal: true

require_relative '../../models/mappers/fm_per_mapper'
require_relative '../../models/mappers/fmBuySell_mappers'
require_relative '../../models/entities/fm_per_entities'
require_relative '../../models/entities/fm_buysell_entities'
require_relative '../values/fm_per_strategy'
require_relative '../values/fm_div_strategy'
require_relative '../values/fm_bsl_strategy'
require_relative '../entities/main_page_fm_entity'

module GoogleTrend
  module Mapper
    class FmDivPreprocessing
      def initialize(entity_class)
        @entity_class = entity_class
      end

      def data_transform(data)
        data = data.split(', ')
        data[0] = data[0][1..]
        data[(data.length - 1)] = data[(data.length - 1)][..-2]
        data.map!(&:to_f)
        data
      end

      def per_value
        data_transform(@entity_class.per)
      end

      def div_yield_value
        data_transform(@entity_class.div_yield)
      end

      def to_entity
        GoogleTrend::Entity::FmPerEntity.new(
          id: nil,
          stock_name: nil,
          time: nil,
          div_yield: GoogleTrend::Value::FmDivStrategy.new(div_yield_value).avg_dividend_yield,
          per: nil,
          pbr: nil
        )
      end
    end
  end
end
