# frozen_string_literal: true

require 'roda'
require 'slim'

module CodePraise
<<<<<<< HEAD
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: 'bootstrap.css', path: 'app/views/assets'
    plugin :common_logger, $stderr
    plugin :halt

    route do |routing|
      routing.assets # load CSS
      response['Content-Type'] = 'text/html; charset=utf-8'

      # GET /
      routing.root do
        view 'home'
      end

      routing.on 'project' do
        view 'home'
      end
    end
  end
end
=======
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
    plugin :common_logger, $stderr
    plugin :halt
    
    route do |routing|
        routing.assets # load CSS
        response['Content-Type'] = 'text/html; charset=utf-8'

        routing.root do
            view 'home'
        end
      
    end
  end
end
>>>>>>> 69e06a595a2f6f31670d7b6e3c19b5f4d1e48ee6
