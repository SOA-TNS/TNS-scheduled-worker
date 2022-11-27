# frozen_string_literal: true

require_relative '../../../helpers/spec_helper_rgt.rb'
require_relative '../../../helpers/vcr_helper.rb'
require_relative '../../../helpers/database_helper.rb'

describe 'AddProject Service Integration Test' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr_for_google_trend
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Retrieve and store stock' do
    before do
      DatabaseHelper.wipe_database
    end

    it 'HAPPY: should be able to find and save remote stock to database' do
      # GIVEN: a valid url request for an existing remote project:
      stock = GoogleTrend::Gt::TrendMapper
        .new.find(Query)
      stock_[:rgt_url] = Query
      # WHEN: the service is called with the request form object
      stock_made = GoogleTrend::Service::AddStock.new.call(stock_)

      # THEN: the result should report success..
      _(stock_made.success?).must_equal true

      # ..and provide a project entity with the right details
      rebuilt = stock_made.value!

      _(rebuilt.query).must_equal(stock.query)
      _(rebuilt.time_series).must_equal(stock.time_series)
   
      end
    end

    it 'HAPPY: should find and return existing project in database' do
      # GIVEN: a valid url request for a project already in the database:
      stock_[:rgt_url] = Query
      db_stock = GoogleTrend::Service::AddStock.new.call(stock_).value!

      # WHEN: the service is called with the request form object
      stock_made = GoogleTrend::Service::AddStock.new.call(stock_)

      # THEN: the result should report success..
      _(stock_made.success?).must_equal true

      # ..and find the same stock that was already in the database
      rebuilt = stock_made.value!

      # ..and provide a project entity with the right details
      _(rebuilt.query).must_equal(db_stock.query)
      _(rebuilt.time_series).must_equal(db_stock.time_series)
      end
    end

    it 'BAD: should gracefully fail for invalid Query' do
      # GIVEN: an invalid url request is formed
      BAD_QUERY = ''
      # WHEN: the service is called with the request form object
      stock[:rgt_url] = BAD_QUERY
      stock_made = GoogleTrend::Service::AddStock.new.call(stock)

      # THEN: the service should report failure with an error message
      _(stock_made.success?).must_equal false
      _(stock_made.failure.downcase).must_include 'could not find'
    end
  end
end