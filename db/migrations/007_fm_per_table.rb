# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:fm_per) do
      primary_key :id
      foreign_key :fmvalues_id, :fmvalues

      String      :time
      String      :div_yield
      String      :per
      String      :pbr

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
