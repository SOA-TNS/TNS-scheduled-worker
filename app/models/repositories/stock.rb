# frozen_string_literal: true

module GoogleTrend
  module Repository
    # Repository for Project Entities
    class Stock
      def self.all # return an array
        Database::StockOrm.all.map { |db_stock| rebuild_entity(db_stock) }
      end

      def self.find_full_name(stock_name) #not sure
        # SELECT * FROM `projects` LEFT JOIN `members`
        # ON (`members`.`id` = `projects`.`owner_id`)
        # WHERE ((`username` = 'owner_name') AND (`name` = 'project_name'))
        db_stock = Database::StockOrm
          .left_join(:gtvalues, id: :query) # ?
          .where(query: stock_name)
          .first
        
        rebuild_entity(db_stock)
      end

      def self.find_id(id)
        db_record = Database::StockOrm.first(id:) 
        rebuild_entity(db_record)
      end

      def self.create(entity)

        db_stock = PersistStock.new(entity).create_stock
        rebuild_entity(db_stock)
      end

      # put into entity
      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::RgtEntity.new(
          db_record.to_hash.merge(
            time_series: db_record.history_trend
          )
        )
      end

      # Helper class to persist project and its members to database
      class PersistStock
        def initialize(entity)
          @entity = entity
        end

        def create_stock
          Database::StockOrm.create(@entity.to_attr_hash)
        end
      end
    end
  end
end