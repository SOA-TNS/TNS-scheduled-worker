# frozen_string_literal: true

require 'dry/transaction'

module GoogleTrend
  module Service
    # Analyzes contributions to a project
    class RiskStock
      include Dry::Transaction

      step :find_stock_details
      step :stock_from_googletrend
      step :cal_risk

      private

      NO_STOCK_ERR = 'Stock not found'
      DB_ERR = 'Having trouble accessing the database'
      SIZE_ERR = 'Project too large to analyze'
      PROCESSING_MSG = 'Processing the summary request'

      # Steps

      def find_stock_details(input) 
        input[:data_record] = Repository::For.klass(Entity::RgtEntity).find_stock_name(input[:requested])
        Success(input) 
      rescue StandardError
        Failure(Response::ApiResult.new(status: :internal_error, message: DB_ERR))
      end

      def stock_from_googletrend(input)
        return Success(input) if input[:data_record]

        Messaging::Queue.new(App.config.FM_QUEUE_URL, App.config)
        # .send(fm_request_json(input))
        .send(Representer::MainRepresenter.new(input[:project]).to_json)
        

        Failure(Response::ApiResult.new(
          status: :processing,
          message: { request_id: input[:request_id], msg: PROCESSING_MSG }
        ))

      rescue StandardError
        raise GH_NOT_FOUND_MSG
      end

      def cal_risk(input)
        input[:risk] = Mapper::DataPreprocessing.new(input[:data_record]).to_entity
        main_info = Response::StockInfo.new(input[:data_record], input[:risk])
        Success(Response::ApiResult.new(status: :ok, message: main_info))
      rescue StandardError
        App.logger.error "Could not find: #{input[:requested]}"
        Failure(Response::ApiResult.new(status: :not_found, message: NO_STOCK_ERR))
      end
    end
  end
end
