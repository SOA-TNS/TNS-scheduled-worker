# frozen_string_literal: true

module CodePraise
  #get data
  class RGTt
    def initialize(rgt_data, rgt_source)
      @rgt = rgt_data
      @rgt_source = rgt_source
    end

    def get_rgt
      @rgt
    end
  end
end