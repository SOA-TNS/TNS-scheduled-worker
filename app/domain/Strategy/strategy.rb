# frozen_string_literal: true

require_relative 'data_preprocessing'
module GoogleTrend
  module Value
    class Strategy
    
      def initialize(extracted_value)
        @extracted_value = extracted_value
      end
      
      def MA3
        sum = 0 
        3.times do |i|
          sum += @extracted_value[i]
        end
        sum/3
      end

      def MA18
        sum = 0 
        18.times do |i|
          sum += @extracted_value[i]
        end
        sum/18
      end

      def at_risk?
        risk = ((MA18() > MA3()) or @extracted_value[0] < 80) ? "not at risk" : "at risk"
        risk
      end
    end
  end
end
