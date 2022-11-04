# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:googletrend_values) do
      primary_key [:stock_id, :value_id] # rubocop:disable Style/SymbolArray
      foreign_key :stock_id, :stock
      foreign_key :value_id, :gtvalues

      index [:stock_id, :query] # rubocop:disable Style/SymbolArray
    end
  end
end
