# frozen_string_literal: true

require_relative 'data_preprocessing'
module GoogleTrend
  module Value
    class Strategy
    
      def initialize(extracted_value)
        @extracted_value = extracted_value
      end
      
      def MA3
        extracted_value = DataPreprocessing().extracted_value
        sum = 0 
        3.times do |i|
          sum += extracted_value[i]
        end
        sum/3
      end

      def MA18
        extracted_value = DataPreprocessing().extracted_value
        sum = 0 
        18.times do |i|
          sum += extracted_value[i]
        end
        sum/18
      end

      def at_risk?
        risk = MA18() > MA3() ? false : true
        risk
      end

    end
  end
end