# encoding: utf-8
module Alchemist
  class Avatar
    attr_reader :name, :x, :y, :inventory

    def initialize(name, x = 0, y = 0, inventory = "")
      @name = name
      @x = x.to_i
      @y = y.to_i
      @inventory = inventory
    end

    def move(direction, max_x, max_y)
      Avatar.new name,
                 *direction.move_from(x, y, max_x, max_y),
                 @inventory
    end

    def add_to_inventory(additions)
      Avatar.new name, x, y, (@inventory + additions).gsub(' ','')
    end

    def remove_from_inventory(removal)
      remover = removal.split('').reduce(-> x { x }) do |r, c|
        -> x { r[x].sub(c,'') }
      end

      Avatar.new name, x, y, remover[@inventory]
    end

    def has?(c)
      @inventory.include? c
    end

    def hash
      name.hash
    end

    def ==(other)
      other.class == self.class &&
      other.name == name
    end

    def eql?(other)
      self == other
    end

    def to_s
      "⚲ #{name} #{x} #{y} #{@inventory}"
    end

    def self.parse(string)
      if string =~ /^⚲ (.*)$/
        new *$1.split(" ")
      end
    end
  end
end

