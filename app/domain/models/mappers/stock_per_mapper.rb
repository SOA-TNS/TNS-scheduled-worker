# frozen_string_literal: true


module GoogleTrend
    module Gt
      class StockNewsMapper
  
        def initialize( data_id, start_date, end_date, gateway_class = Gt::StockApi)
          @data_id = data_id
          @gateway_class = gateway_class
          @start_date =start_date
          @end_date = end_date
          @gateway = @gateway_class.new("TaiwanStockPER", @data_id, @start_date, @end_date)
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
              time:,
              per:,
              pbr:
            )
          end
  
          def stock_name
            @stock["data"][0]["stock_id"]
          end
  
          def time
            date = []
            value_over_time = @stock["data"] #hash
            value_over_time.each{ |value| date << value["date"] } #array
            date.to_s
          end

          def per
            per = []
            value_over_time = @stock["data"] #hash
            value_over_time.each{ |value| per << value["PER"] } #array
            per.to_s
          end
          
          def pbr
            pbr = []
            value_over_time = @stock["data"] #hash
            value_over_time.each{ |value| pbr << value["PBR"] } #array
            pbr.to_s
          end  
        end
      end
    end
  end