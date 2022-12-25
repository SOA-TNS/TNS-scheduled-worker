# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'main_fm_representer'
require_relative 'fm_bsl_representer'

module Finmind
  module Representer
    class FmBslInfo < Roar::Decorator
      include Roar::JSON

      property :data_record, extend: Representer::FmBslRepresenter, class: OpenStruct
      property :net_buy_probability, extend: Representer::MainFmRepresenter, class: OpenStruct
    end
  end
end
