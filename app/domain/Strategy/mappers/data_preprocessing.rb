# frozen_string_literal: true

module GoogleTrend
  module Mapper
    class DataPreprocessing
      def initialize(entity_class = GoogleTrend::Entity::RgtEntity)
        @entity_class = entity_class
      end

      def query
        @entity_class.query
      end

      def extracted_value
        time_series = @entity_class.time_series
        time_series = time_series.split("\"")
        time_series.select!{|str| str.length >= 20}
        time_series.map!{|element| element[-3..-1].to_f}
        time_series.reverse()
      end

      def to_entity
        Entity::MainPageEntity.new(
          query: query(),
          risk: GoogleTrend::Value::Strategy.new(extracted_value()).at_risk?
        )
      end
    end
  end
end