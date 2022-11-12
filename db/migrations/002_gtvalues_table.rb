# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:gtvalues) do
      primary_key :id
      foreign_key :query_id, :stock

      String      :query
      String      :time_series
      DateTime    :date

      DateTime :created_at
      DateTime :updated_at
    end
  end
end