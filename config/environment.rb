# frozen_string_literal: true

require 'figaro'
require 'logger'
require 'roda'

require 'sequel'

module GoogleTrend
  class App < Roda
    plugin :environments

    # Environment variables setup
    Figaro.application = Figaro::Application.new(
      environment:,
      path: File.expand_path('config/secrets.yml')
    )
    Figaro.load
    def self.config = Figaro.env
    
    configure :app_test do
      require_relative '../spec/helpers/vcr_helper'
      VcrHelper.setup_vcr
      VcrHelper.configure_vcr_for_google_trend
    end

    # Database Setup
    configure :development, :test , :app_test do
      require 'pry'; # for breakpoints
      ENV['DATABASE_URL'] = "sqlite://#{config.DB_FILENAME}"
    end

    DB = Sequel.connect(ENV.fetch('DATABASE_URL'))
    def self.DB = DB # rubocop:disable Naming/MethodName

    # Logger Setup
    LOGGER = Logger.new($stderr)
    def self.logger = LOGGER
  end
end
