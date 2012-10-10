# encoding: utf-8
module Alchemist
  class Avatar
    INVENTORY_SIZE = 64
    attr_reader :name, :x, :y, :inventory

    def initialize(name, x = 0, y = 0, inventory = "")
      @name = name
      @x = x.to_i
      @y = y.to_i
      @inventory = inventory
    end

    def move(direction)
      Avatar.new name,
                 *direction.move_from(x, y),
                 @inventory
    end

    def add_to_inventory(additions)
      Avatar.new(name, x, y, (@inventory + additions).gsub(' ','')).tap do |a|
        if a.inventory.length > INVENTORY_SIZE
          raise "You can only carry #{INVENTORY_SIZE} items"
        end
      end
    end

    def remove_from_inventory(*removals)
      remover = removals.join('').split('').reduce(-> x { x }) do |r, c|
        -> x { r[x].sub(c,'') }
      end

      Avatar.new name, x, y, remover[@inventory]
    end

    def has?(*items)
      items.all? { |i| @inventory.include? i }
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

