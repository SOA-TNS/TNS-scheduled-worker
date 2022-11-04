require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
	@@ -17,4 +16,5 @@
CORRECT = YAML.safe_load(File.read('spec/fixtures/rgt_results.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'rgt_api'
ENV['RACK_ENV'] = 'test'