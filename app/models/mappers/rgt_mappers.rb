# frozen_string_literal: true
require_relative '../entities/rgt_entities'
require_relative '../gateways/rgt_api'

module GoogleTrend
  module Gt
    class TrendMapper

      def initialize(name, gateway_class = Gt::RgtApi)
        @config = YAML.safe_load(File.read('secrets.yml')) 
        @name = name
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@config, @name)
      end

      def find
        rgt = @gateway.jason
        build_entity(rgt)
      end

      def build_entity(rgt)
        DataMapper.new(rgt).build_entity
      end

      class DataMapper
        def initialize(rgt)
          @rgt = rgt
        end
        def build_entity
          GoogleTrend::Entity::RgtEntity.new(
            query:,
            time_series:
          )
        end
        def query
          @rgt['search_parameters']['q']
        end
        def time_series
          data = @rgt['interest_over_time']
        end
      end
    end
  end
end

print(GoogleTrend::Gt::TrendMapper.new('TSMC').find)
print("\n") 
print(GoogleTrend::Gt::TrendMapper.new('TSMC').find.time_series)
#print("\n") 
#print(GoogleTrend::Gt::TrendMapper.new('TSMC').find.time_series)