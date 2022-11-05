# frozen_string_literal: true

require_relative 'stocks'
require_relative 'values'

module GoogleTrend
  module Repository
    # Finds the right repository for an entity object or class
    module For
      ENTITY_REPOSITORY = {
        Entity::RgtEntity => RgtEntities,
      }.freeze

      def self.class(entity_class)
        ENTITY_REPOSITORY[entity_class]
      end

      def self.entity(entity_object)
        ENTITY_REPOSITORY[entity_object.class]
      end
    end
  end
end