module Alchemist
  class World
    attr_reader :geography

    def initialize(avatars, geography)
      @avatars = avatars
      @geography = geography
    end

    def to_s
      (@avatars.to_a.map(&:to_s) + [@geography]).join("\n")
    end

    def new_avatar(name)
      a = Avatar.new name
      World.new @avatars | [a], @geography
    end

    def avatar(name)
      locator = Avatar.new name
      @avatars.detect { |a| a == locator }
    end

    def move(avatar_name, direction)
      a = avatar(avatar_name)
      return self unless a


      a_prime = a.move direction, *dimensions

      World.new @avatars - [a] + [a_prime],
                @geography
    end

    def location(avatar_name)
      a = avatar avatar_name
      [a.try(:x), a.try(:y)]
    end

    def dimensions
      lines = geography.lines.map(&:chomp)
      [lines.first.length, lines.length]
    end

    def self.parse(string)
      avatars = string.lines.to_list
                .map { |l| Avatar.parse l }
                .take_while { |a| a }

      new avatars.to_set, string.lines.drop(avatars.length).join('')
    end
  end
end

