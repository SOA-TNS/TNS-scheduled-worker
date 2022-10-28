# frozen_string_literal: true
require 'yaml'
require 'http'
require_relative 'rgt_api'

module CodePraise
  # access google trend
  class RGT
    API_PROJECT_ROOT = 'https://serpapi.com/search.json?'
  
    attr_reader :parameter

    def initialize(name)
      config = YAML.safe_load(File.read('config/secrets.yml'))
      @parameter = {
        engine: "google_trends",
        q: name,
        data_type: "TIMESERIES",   
        api_key: config['api_key']    
      }
    end



    def get_jason
      rgt_data = Request.new(API_PROJECT_ROOT).rgt(@parameter).parse
      RGTt.new(rgt_data, self)
    end

    #get data by url
    class Request
      def initialize(resource_root)
        @resource_root = resource_root
      end

      def rgt(parameter)
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
