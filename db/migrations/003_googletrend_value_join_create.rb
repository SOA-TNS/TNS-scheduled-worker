# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:googletrend_values) do
      primary_key [:value_id, :stock_id] # rubocop:disable Style/SymbolArray
      foreign_key :value_id, :gtvalues
      foreign_key :stock_id, :stock

      index [:value_id, :stock_id] # rubocop:disable Style/SymbolArray
    end
  end
end
