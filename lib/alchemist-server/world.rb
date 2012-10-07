module Alchemist
  class World
    attr_reader :geography

    def initialize(avatars, geography)
      @avatars = avatars
      @geography = geography
    end

    def to_s
      (@avatars.map(&:to_s) + [@geography]).join("\n")
    end

    def new_avatar(name)
      a = Avatar.new name
      World.new @avatars | [a], @geography
    end

    def self.parse(string)
      avatars = string.each_line.to_list
                .map { |l| Avatar.parse l }
                .take_while { |a| a }

      new avatars.to_set, string.each_line.drop(avatars.length).join('')
    end
  end
end

