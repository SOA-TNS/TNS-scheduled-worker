# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'main_fm_representer'
require_relative 'fm_per_representer'

module Finmind
  module Representer
    class FmDivInfo < Roar::Decorator
      include Roar::JSON

      property :data_record, extend: Representer::FmPerRepresenter, class: OpenStruct
      property :avg_dividend_yield, extend: Representer::MainFmRepresenter, class: OpenStruct
    end
  end
end
