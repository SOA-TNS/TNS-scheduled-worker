# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:stock) do
      primary_key :id

      String :query
      Array :time_series

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
