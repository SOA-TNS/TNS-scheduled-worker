# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:stock) do
      primary_key :id
      
      String   :stock_name, unique: true, null: false
      DateTime :created_at
      DateTime :processed_at
    end
  end
end
