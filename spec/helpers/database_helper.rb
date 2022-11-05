# frozen_string_literal: true

# Helper to clean database during test runs
module DatabaseHelper
  def self.wipe_database
    # Ignore foreign key constraints when wiping tables
    GoogleTrend::App.DB.run('PRAGMA foreign_keys = OFF')
    GoogleTrend::Database::StockOrm.map(&:destroy)
    GoogleTrend::Database::ValueOrm.map(&:destroy)
    GoogleTrend::App.DB.run('PRAGMA foreign_keys = ON')
  end
end