# frozen_string_literal: true

require 'dry/transaction'

module GoogleTrend
  module Service
    # Analyzes contributions to a project
    class RiskStock
      include Dry::Transaction

      step :ensure_watched_stock
      step :retrieve_stock
      step :appraise_risk

      private

      # Steps
      def ensure_watched_stock(input)
        if input[:watched_list].include? input[:requested]
          Success(input)
        else
          Failure('Please first request this stock to be added to your list')
        end
      end

      def retrieve_stock(input)
        input[:data_record] = Repository::For.klass(Entity::RgtEntity).find_stock_name(input[:requested])

        input[:data_record] ? Success(input) : Failure('Stock not found')
      rescue StandardError
        Failure('Having trouble accessing the database')
      end

      def appraise_risk(input)
        input[:risk] = Mapper::DataPreprocessing.new(input[:data_record]).to_entity

        Success(input)
      rescue StandardError
        App.logger.error "Could not find: #{input[:requested]}"
        Failure('Could not find that stock')
      end

    end
  end
end
