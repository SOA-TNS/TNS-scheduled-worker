# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:fm_fear) do
      primary_key :id

      String      :time
      String      :fear_greed
      DateTime    :fear_greed_emotion

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
