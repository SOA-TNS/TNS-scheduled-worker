# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:googletrend_values) do
      primary_key [:gt_value, :fm_value] # rubocop:disable Style/SymbolArray
      foreign_key :gt_value, :gtvalues
      foreign_key :fm_value, :fmvalues

      index [:gt_value, :fm_value] # rubocop:disable Style/SymbolArray
    end
  end
end
