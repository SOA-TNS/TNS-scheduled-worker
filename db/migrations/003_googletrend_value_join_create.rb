# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:googletrend_values) do
      primary_key [:stock_id, :query] # rubocop:disable Style/SymbolArray
      foreign_key :stock_id, :stock
      foreign_key :query, :gtvalues

      index [:stock_id, :query] # rubocop:disable Style/SymbolArray
    end
  end
end