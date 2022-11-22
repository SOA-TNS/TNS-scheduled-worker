# frozen_string_literal: true

module GoogleTrend
    module Gt
      class StockInstitutionalInvestorsBuySellMapper
  
        def initialize( data_id, start_date, end_date, gateway_class = Gt::StockApi)
          @data_id = data_id
          @gateway_class = gateway_class
          @start_date = start_date
          @end_date = end_date
          @gateway = @gateway_class.new("TaiwanStockInstitutionalInvestorsBuySell", @data_id, @start_date, @end_date)
        end
  
        def find
          stock = @gateway.jason
          build_entity(stock)
        end
  
        def build_entity(stock)
          DataMapper.new(stock).build_entity
        end
  
        class DataMapper
  
          def initialize(stock)
            @stock = stock
          end
  
          def build_entity
            GoogleTrend::Entity::StoctEntity.new(
              id: nil,
              stock_name:,
              name:,
              per:,
              pbr:
            )
          end
  
          def stock_name
            @stock["data"][0]["stock_id"]
          end
  
          def name
            name = []
            value_over_time = @stock["data"] #hash
            value_over_time.each{ |value| name << value["name"] } #array
            name.to_s
          end

          def buy
            buy = []
            value_over_time = @stock["data"] #hash
            value_over_time.each{ |value| buy << value["buy"] } #array
            buy.to_s
          end
          
          def sell
            sell = []
            value_over_time = @stock["data"] #hash
            value_over_time.each{ |value| sell << value["sell"] } #array
            sell.to_s
          end  
        end
      end
    end
  end