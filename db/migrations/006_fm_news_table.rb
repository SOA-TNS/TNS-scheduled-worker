# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:fm_news) do
      primary_key :id
      foreign_key :fmvalues_id, :fmvalues

      String      :date
      String      :link
      String      :source
      String      :title

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
