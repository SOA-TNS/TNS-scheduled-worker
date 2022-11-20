# frozen_string_literal: true

require 'yaml'
require 'http'

module FinMind
  module Stock
    class StockApi
      FM_PATH = 'https://api.finmindtrade.com/api/v4/data?'

      attr_reader :parameter
  
      def initialize(dataset, data_id, start_date, end_date)
        @parameter = {
          dataset: dataset,
          data_id: data_id,
          start_date: start_date,
          end_date: end_date
        }
      end
  

      def jason
        stock_data = Request.new(FM_PATH).fm(@parameter).parse
        stock_data
      end

      # get data by url
      class Request
        def initialize(resource_root)
          @resource_root = resource_root
        end
  
        def fm(parameter)
          get(@resource_root + parameter.to_a.collect { |col| col.join('=') }.join('&'))
        end
        
        def get(url)
          http_response = HTTP.get(url)
  
          Response.new(http_response).tap do |response|
            raise(response.error) unless response.successful?
          end
        end
      end

      # Decorates HTTP responses from FinMind with success/error reporting
      class Response < SimpleDelegator
        # Response when get Http status code 401 (Unauthorized)
        Unauthorized = Class.new(StandardError)

        # Response when get Http status code 404 (Not Found)
        NotFound = Class.new(StandardError)

        HTTP_ERROR = {
          401 => Unauthorized,
          404 => NotFound
        }.freeze

        def successful?
          HTTP_ERROR.keys.none?(code)
        end

        def error
          HTTP_ERROR[code]
        end
      end
    end
  end
end
