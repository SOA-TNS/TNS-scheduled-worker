# frozen_string_literal: true

require 'roda'
require 'slim'

module CodePraise
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
    
              routing.redirect "Gtrend/#{rgt_url}"
            end
          end

          routing.on String do |qry|
            # GET /project/owner/project
            routing.get do
              rgt_name = GoogleTrend::TrendMapper
                .new(qry).get_rgt.query
              rgt_dic = GoogleTrend::TrendMapper
                .new(qry).get_rgt.time_series
              view 'Gtrend', locals: { name: rgt_name, interest_over_time: rgt_dic }
            end
          end
        end
    end
  end
end