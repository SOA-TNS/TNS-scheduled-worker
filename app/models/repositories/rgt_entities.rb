# frozen_string_literal: true

module GoogleTrend
  module Repository
    # Repository for Members
    class RgtEntities
      def self.find_id(id)
        rebuild_entity Database::StockOrm.first(id:)
      end

      def self.find_username(stock_name)
        rebuild_entity Database::StockOrm.first(stock_name:)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::RgtEntity.new(
          query: ,
          time_series: 
        )
      end

      def self.rebuild_many(db_records)
        db_records.map do |db_member|
          RgtEntities.rebuild_entity(db_member)
        end
      end
    end
  end
end