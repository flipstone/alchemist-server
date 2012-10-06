module Alchemist
  class World
    attr_reader :geography

    def initialize(geography)
      @geography = geography
    end

    def to_s
      @geography
    end

    def self.parse(string)
      new string
    end
  end
end

