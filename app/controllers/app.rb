# frozen_string_literal: true

require 'roda'
require 'slim'

module GoogleTrend

  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: 'bootstrap.css', path: 'app/views/assets'
    plugin :common_logger, $stderr

    
    route do |routing|
        response['Content-Type'] = 'text/html; charset=utf-8'

        routing.root do
            view 'home'
        end

        routing.on 'Gtrend' do
          routing.is do
          
            routing.post do
              rgt_url = routing.params['searchStock'].downcase

              trend = GoogleTrend::Gt::TrendMapper.new('BTC', App.config.RGT_TOKEN).find
              
              GoogleTrend::Repository::For.entity(trend).create(trend)
              
              routing.redirect "Gtrend/#{rgt_url}"
            end
          end

          routing.on String do |qry|
            # GET /project/owner/project
            routing.get do
              project = Repository::For.klass(Entity::RgtEntity).find_stock_name("BTC")

              rgt_name = project.query

              rgt_dic = project.time_series
              view 'Gtrend', locals: { name: rgt_name, interest_over_time: rgt_dic }
            end
          end
        end
    end
  end
end