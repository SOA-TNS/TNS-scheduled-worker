# frozen_string_literal: true

require 'roda'
require 'slim'
require 'slim/include'

# require_relative 'helpers'
require_relative '../../presentation/view_object/main_page'

module GoogleTrend
  class App < Roda
    plugin :halt
    plugin :flash
    plugin :all_verbs
    plugin :render, engine: 'slim', views: 'app/presentation/views_html'
    plugin :assets, css: 'bootstrap.css', path: 'app/presentation/assets/css'
    plugin :common_logger, $stderr

    route do |routing|
      routing.assets
      response['Content-Type'] = 'text/html; charset=utf-8'

      routing.root do
        session[:watching] ||= []
        
        # 從service拿到過去的搜尋歷史
        result = Service::ListStocks.new.call(session[:watching])

        # 從是否發生錯誤決定要不清空歷史紀錄後，若沒有錯誤再判斷是否為空值，若為空值再顯示訊息'Add a Github project to get started'
        # 最後將名稱記錄至 session[:watching]內，並透過view object取得資訊顯示在畫面上
        if result.failure?
          flash[:error] = result.failure
          viewable_projects = []
        else
          stocks = result.value!
          if stocks.none?
            flash.now[:notice] = 'Add a Github project to get started'
          end
          
          session[:watching] = stocks.map(&:query)
          # viewable_projects = Views::ProjectsList.new(projects)
        end

        view 'home'
      end

      routing.on 'Gtrend' do
        routing.is do
          routing.post do
            # 傳入routing.params['searchStock']的值，從Form object驗證傳入值是否正確(是否為股票名稱或代碼)
            # stock_request = Forms::NewStock.new.call(routing.params)
            stock_made = Service::AddStock.new.call(routing.params)
            if stock_made.failure?
              flash[:error] = stock_made.failure
              routing.redirect '/'
            end
            
            stock = stock_made.value!
            session[:watching].insert(0, stock.query).uniq!
            flash[:notice] = 'Project added to your list'
            routing.redirect "Gtrend/#{stock.query}"
          end
        end

        routing.on String do |qry|
          # 預計討論刪除
          # GET /project/owner/project
          # routing.delete do
          #   stockname = qry.to_s
          #    session[:watching].delete(stockname)

          #   routing.redirect '/'
          # end

          routing.get do
            # 傳入session[:watching]的紀錄和當前查詢的內容至Service
            session[:watching] ||= []

            result = Service::RiskStock.new.call(
                watched_list: session[:watching],
                requested: qry
                )
            
            if result.failure?
              flash[:error] = result.failure
              routing.redirect '/'
            end
            
            stock = result.value!
            stock_trend = Views::MainPageInfo.new(stock[:data_record], stock[:risk])
            view 'Gtrend', locals: { stock_trend: }
          end
        end
      end
    end
  end
end
