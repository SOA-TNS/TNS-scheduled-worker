# frozen_string_literal: true

require 'dry/transaction'

module GoogleTrend
  module Service
    # Transaction to store stock from GoogleTrend API to database
    class AddStock
      include Dry::Transaction

      step :find_stock
      step :store_stock

      private
 
      def find_stock(input)
        if (stock = stock_in_database(input))
          input[:local_stock] = stock
        else
          input[:remote_stock] = stock_from_googletrend(input)
        end
        Success(input)
      rescue StandardError => error
        Failure(error.to_s)
      end

      def store_stock(input)
        stock =
          if (new_stock = input[:remote_stock])
            GoogleTrend::Repository::For.entity(new_stock).create(new_stock)
          else
            input[:local_stock]
          end
        Success(stock)
      rescue StandardError => error
        App.logger.error error.backtrace.join("\n")
        Failure('Having trouble accessing the database')
      end

      # following are support methods that other services could use

      def stock_from_googletrend(input)
        GoogleTrend::Gt::TrendMapper.new(input["rgt_url"], App.config.RGT_TOKEN).find
      rescue StandardError
        raise 'Could not find that Stock data'
      end

      def stock_in_database(input)
        Repository::For.klass(Entity::RgtEntity)
        .find_stock_name(input["rgt_url"])
      end
    end
  end
end