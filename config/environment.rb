# frozen_string_literal: true

require 'figaro'
require 'logger'
require 'roda'
require 'rack/session'
require 'sequel'

module GoogleTrend
  # Configuration for the App
  class App < Roda
    plugin :environments

    # rubocop:disable Lint/ConstantDefinitionInBlock
    
      # Environment variables setup
      Figaro.application = Figaro::Application.new(
        environment:,
        path: File.expand_path('config/secrets.yml')
      )
      Figaro.load
      def self.config = Figaro.env

      use Rack::Session::Cookie, secret: config.SESSION_SECRET

      configure :development, :test do
        require 'pry';
        ENV['DATABASE_URL'] = "sqlite://#{config.DB_FILENAME}"
      end

      # Database Setup
      DB = Sequel.connect(ENV.fetch('DATABASE_URL'))

      def self.DB = DB # rubocop:disable Naming/MethodName
      
      LOGGER = Logger.new($stderr)
      def self.logger = LOGGER
  end
end