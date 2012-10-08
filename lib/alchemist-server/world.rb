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

    def at(avatar_name)
      a = avatar(avatar_name)
      return unless a
      @geography.at a.x, a.y
    end

    def take(avatar_name)
      a = avatar(avatar_name)
      return self unless a

      resource = geography.at a.x, a.y
      new_a = a.add_to_inventory resource
      new_g = geography.take a.x, a.y

      World.new @avatars - [a] + [new_a],
                new_g
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
      @geography.dimensions
    end

    def self.parse(string)
      avatars = string.lines.to_list
                .map { |l| Avatar.parse l }
                .take_while { |a| a }

      geo = Geography.new string.lines.drop(avatars.length).join('')
      new avatars.to_set, geo
    end
  end
end

