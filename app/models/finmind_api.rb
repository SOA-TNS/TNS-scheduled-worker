# frozen_string_literal: true

require 'http'
require_relative 'finmind'

module FinMindAPI
  # Client Library for FinMind API
  class FinMindApi
    FM_PATH = 'https://api.finmindtrade.com/api/v4/data?'

    attr_reader :parameter

    def initialize
      @parameter = {}
    end

    def dataset(dataset)
      @parameter['dataset'] = dataset
    end

    def data_id(data_id)
      @parameter['data_id'] = data_id
    end

    def start_date(start_date)
      @parameter['start_date'] = start_date
    end

    def end_date(end_date)
      @parameter['end_date'] = end_date
    end

    def remove_set
      @parameter.delete('dataset')
    end

    def remove_id
      @parameter.delete('data_id')
    end

    def remove_start
      @parameter.delete('start_date')
    end

    def remove_end
      @parameter.delete('end_date')
    end

    def finMind
      stock_data = Request.new(FM_PATH).fm(@parameter).parse
      FinMind.new(stock_data, self)
    end

    # Sends out HTTP requests to FinMind
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
        404 => NotFound,
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
