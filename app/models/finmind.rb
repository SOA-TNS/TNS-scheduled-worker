# frozen_string_literal: true

module FinMindAPI

  # Model for Stock
  class FinMind
    def initialize(stock_data, data_source)
      @stock = stock_data
      @data_source = data_source
    end

    def get_stock
      @stock
    end
  end
end
