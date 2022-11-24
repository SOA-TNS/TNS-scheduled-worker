# frozen_string_literal: true

module GoogleTrend
  module Value
    class FmDivStrategy
      def initialize(div_value)
        @div_value = div_value
      end

      def avg_div(div_value)
        days = div_value.length
        sum = 0
        div_value.each { |value| sum += value }
        (sum / days).round(2)
      end

      def avg_dividend_yield
        avg = avg_div(@div_value)
        if avg > 4
          "#{avg}% => high"
        elsif avg >= 1.5 && avg <= 4
          "#{avg}% => acceptable"
        else
          "#{avg}% => low"
        end
      end
    end
  end
end
