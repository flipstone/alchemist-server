module Alchemist
  class World
    attr_reader :geography

    def initialize(avatars, formulas, geography)
      @avatars = avatars
      @formulas = formulas
      @geography = geography
    end

    def to_s
      (@avatars.to_a.map(&:to_s) + [@geography]).join("\n")
    end

    def new_avatar(name)
      a = Avatar.new name
      World.new @avatars | [a], @formulas, @geography
    end

    def formulate(avatar_name, elem_1, elem_2, novel_elem)
      if @formulas[novel_elem].nil?
        f = Formula.new elem_1, elem_2, novel_elem

        w = World.new @avatars,
                      @formulas.put(novel_elem, f),
                      @geography
        w.forge(avatar_name, elem_1, elem_2, novel_elem)
      else
        raise "There is already a formula for #{novel_elem}"
      end
    end

    def forge(avatar_name, elem_1, elem_2, result)
      a = avatar avatar_name

      if !a.has?(elem_1, elem_2)
        raise "#{avatar_name} doesn't have the required elements"
      end

      f = Formula.new elem_1, elem_2, result

      if @formulas[result] == f
        a_temp = a.remove_from_inventory elem_1, elem_2
        a_prime = a_temp.add_to_inventory result

        World.new @avatars - [a] + [a_prime],
                  @formulas,
                  @geography
      else
        raise "Incorrect formula for #{result}"
      end
    end

    def avatar(name)
      locator = Avatar.new name
      @avatars.detect { |a| a == locator } ||
      raise("#{name} isn't in the world")
    end

    def at(avatar_name)
      a = avatar(avatar_name)
      @geography.at a.x, a.y
    end

    def take(avatar_name)
      a = avatar(avatar_name)

      resource = geography.at a.x, a.y
      new_a = a.add_to_inventory resource
      new_g = geography.take a.x, a.y

      World.new @avatars - [a] + [new_a],
                @formulas,
                new_g
    end

    def put(avatar_name, c)
      a = avatar(avatar_name)

      if a.has? c
        new_g = geography.put a.x, a.y, c
        new_a = a.remove_from_inventory c

        World.new @avatars - [a] + [new_a],
                  @formulas,
                  new_g
      else
        raise "#{avatar_name} doesn't have #{c}"
      end
    end

    def create(avatar_name, c)
      a = avatar(avatar_name)
      new_a = a.add_to_inventory c

      World.new @avatars - [a] + [new_a],
                @formulas,
                @geography
    end

    def move(avatar_name, direction)
      a = avatar(avatar_name)
      a_prime = a.move direction

      World.new @avatars - [a] + [a_prime],
                @formulas,
                @geography
    end

    def location(avatar_name)
      a = avatar avatar_name
      [a.try(:x), a.try(:y)]
    end

    def dimensions
      @geography.dimensions
    end

    def self.genesis
      World.new [], Hamster.hash, Geography.new
    end
  end
end

