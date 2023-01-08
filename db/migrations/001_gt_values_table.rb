# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:gtvalues) do
      primary_key :id

      String      :query
      String      :time_series

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
