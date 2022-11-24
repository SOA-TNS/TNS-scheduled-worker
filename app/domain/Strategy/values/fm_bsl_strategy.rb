# frozen_string_literal: true

module GoogleTrend
  module Value
    class FmBslStrategy
      def initialize(buy_sell_diff)
        @buy_sell_diff = buy_sell_diff
        @days = @buy_sell_diff.length
      end

      def foreign_investor_rate
        fi = []
        (0...@days).each do |i|
          fi.append(@buy_sell_diff[i]) if i % 5 == 3
        end
        pos = 0
        fi.each { |diff| pos += 1 if diff.positive? }
        pos_rate = (pos.to_f / fi.length).round(2)
      end

      def investment_trust_rate
        it = []
        (0...@days).each do |i|
          it.append(@buy_sell_diff[i]) if i % 5 == 4
        end
        pos = 0
        it.each { |diff| pos += 1 if diff.positive? }
        pos_rate = (pos.to_f / it.length).round(2)
      end

      def dealer_self_rate
        ds = []
        (0...@days).each do |i|
          ds.append(@buy_sell_diff[i]) if i % 5 == 1
        end
        pos = 0
        ds.each { |diff| pos += 1 if diff.positive? }
        pos_rate = (pos.to_f / ds.length).round(2)
      end

      def net_buy_probability
        "foreign_investor: #{foreign_investor_rate}, investment_trust: #{investment_trust_rate}, dealer_self: #{dealer_self_rate}"
      end
    end
  end
end
