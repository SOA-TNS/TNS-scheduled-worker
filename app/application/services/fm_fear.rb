# frozen_string_literal: true

require 'dry/transaction'

module GoogleTrend
  module Service
    # Transaction to store stock from GoogleTrend API to database
    class FmFear
      include Dry::Transaction

      step :find_FmFear
      step :store_FmFear

      private

      DB_ERR_MSG = 'Having trouble accessing the database'
      GH_NOT_FOUND_MSG = 'Could not find that stock on GoogleTrend'
 
      def find_FmFear(input)
        if (stock = fm_in_database(input))
          input[:local_stock] = stock
        else
          input[:remote_stock] = stock_from_FmFear(input)
        end
        Success(input)
      rescue StandardError => e
        Failure(Response::ApiResult.new(status: :not_found, message: e.to_s))
      end

      def store_FmFear(input)
        stock =
          if (new_stock = input[:remote_stock])
            GoogleTrend::Repository::For.entity(new_stock).create(new_stock)
          else
            input[:local_stock]
          end
        Success(Response::ApiResult.new(status: :created, message: stock))
      rescue StandardError => e
        puts e.backtrace.join("\n")
        Failure(Response::ApiResult.new(status: :internal_error, message: DB_ERR_MSG))
      end

      # following are support methods that other services could use

      def stock_from_FmFear(input)
        
        GoogleTrend::Gt::FmFearMapper.new(input["rgt_url"]).find
      rescue StandardError
        raise GH_NOT_FOUND_MSG
      end

      def fm_in_database(input)
        Repository::For.klass(Entity::FmFearEntity).find_stock_name(input["rgt_url"])
      end
    end
  end
end