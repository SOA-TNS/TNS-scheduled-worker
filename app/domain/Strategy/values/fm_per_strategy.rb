# frozen_string_literal: true

module GoogleTrend
  module Value
    class FmPerStrategy
      def initialize(per_value)
        @per_value = per_value
      end

      def avg_per_value(per_value)
        days = per_value.length
        sum = 0
        per_value.each { |value| sum += value }
        (sum / days).round(2)
      end

      def avg_per
        avg = avg_per_value(@per_value)
        if avg > 20
          "#{avg} => expensive"
        elsif avg >= 12 && avg < 20
          "#{avg} => acceptable"
        else
          "#{avg} => cheap"
        end
      end
    end
  end
end
