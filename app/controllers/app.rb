# frozen_string_literal: true
require 'roda'
require 'slim'
require 'slim/include'
require_relative "../presentation/view_object/main_page"

module GoogleTrend

  class App < Roda
    rgt_url=""
    plugin :halt
    plugin :flash
    plugin :all_verbs
    plugin :render, engine: 'slim', views: 'app/presentation/views_html'
    plugin :assets, css: 'bootstrap.css', path: 'app/presentation/assets/css'
    plugin :common_logger, $stderr

    use Rack::MethodOverride
    
    route do |routing|
      routing.assets
      response['Content-Type'] = 'text/html; charset=utf-8'

      routing.root do
        # session[:watching] ||= []
        # data_record = Repository::For.klass(Entity::RgtEntity).find_stock_names(session[:watching])
        # session[:watching] = data_record.map(&:stockname)
        # if data_record.none?
        #   flash.now[:notice] = 'Search something to get started'
        # end

        # stocks_list = Views::StocksList.new(projects)

        view 'home'
      end

        routing.on 'Gtrend' do
          
          routing.is do
          
            routing.post do
              rgt_url = routing.params['searchStock']
              routing.redirect "Gtrend/#{rgt_url}"
            end
          end

          routing.on String do |qry|
            # GET /project/owner/project
            routing.delete do
              stockname = "#{qry}"
              # session[:watching].delete(stockname)
  
              routing.redirect '/'
            end
            
            routing.get do
              data_record = Repository::For.klass(Entity::RgtEntity).find_stock_name(rgt_url)
              unless data_record
                begin
                  trend = GoogleTrend::Gt::TrendMapper.new(qry, App.config.RGT_TOKEN).find
                rescue StandardError
                  flash[:error] = 'Could not find that Stock data'
                  routing.redirect '/'
                end
                
                begin
                  GoogleTrend::Repository::For.entity(trend).create(trend)
                rescue StandardError => err
                  logger.error err.backtrace.join("\n")
                  flash[:error] = 'Having trouble accessing the database'
                end
              end
              # puts(data_record.query)
              # session[:watching].insert(0, data_record.query).uniq!
              
              data_record = Repository::For.klass(Entity::RgtEntity).find_stock_name(rgt_url)
              stock =  Mapper::DataPreprocessing.new(data_record).to_entity                
              
              stock_trend = Views::MainPageInfo.new(data_record, stock)

              view 'Gtrend', locals: { stock_trend: }
              
              #rgt_name = stock.query
              #rgt_dic = stock.risk
              
              #view 'Gtrend', locals: { name: rgt_name, interest_over_time: rgt_dic }
            end
          end
      end
    end
  end
end
