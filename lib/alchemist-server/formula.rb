# encoding: utf-8
module Alchemist
  class Formula
    attr_reader :elem_1, :elem_2, :result

    def initialize(elem_1, elem_2, result)
      @elem_1 = elem_1
      @elem_2 = elem_2
      @result = result
    end

    def to_s
      "⨍ #{@elem_1}#{@elem_2}#{@result}"
    end

    def ==(other)
      other.class == self.class &&
      other.elem_1 == elem_1 &&
      other.elem_2 == elem_2 &&
      other.result == result
    end
  end
end

