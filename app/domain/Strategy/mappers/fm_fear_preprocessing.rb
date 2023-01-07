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
    class FmFearPreprocessing
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

      def fear_value
        data_transform(@entity_class.fear_greed)
      end

      def to_entity
        GoogleTrend::Entity::FmFearEntity.new(
          id: nil,
          time: nil,
          fear_greed: GoogleTrend::Value::FmFearStrategy.new(fear_value).fear_value,
          fear_greed_emotion: GoogleTrend::Value::FmFearStrategy.new(fear_value).fr_strategy
        )
      end
    end
  end
end
