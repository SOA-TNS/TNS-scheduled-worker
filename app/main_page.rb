# frozen_string_literal: true

module Views
  class MainPageInfo
    def initialize(data_recoed, stock, index=nil)
      @data_recoed = GoogleTrend::Entity::RgtEntity.new(data_recoed)
      @stock = stock
      @index = index
    end

    def query
      @stock.query    
    end

    def risk
      @stock.risk
    end

    def interest_over_time
      @stock.interest_over_time
    end
  end
end