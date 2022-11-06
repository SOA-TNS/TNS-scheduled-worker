# frozen_string_literal: true

require 'http'
require 'yaml'

def rgt_api_path(name)
  "https://serpapi.com/search.json?&engine=google_trends&q=#{name}&dataset=TIMESERIES&api_key=88fc96111ce19cfb3fa4eb149e1aa32df56db927da85503dcd16d2b37e711771"
end

def call_rgt_url(url)
  HTTP.get(url)
end

def rgt_data(data)
  data.each { |stock| puts stock }
end
rgt_response = {}
rgt_results = {}
project_url = rgt_api_path('TSLA')
rgt_response[project_url] = call_rgt_url(project_url)
project = rgt_response[project_url].parse

rgt_results['search_metadata'] = project['search_metadata']

rgt_results['search_parameters'] = project['search_parameters']

rgt_results['interest_over_time'] = project['interest_over_time']

File.write('spec/fixtures/rgt_results.yml', rgt_results.to_yaml)