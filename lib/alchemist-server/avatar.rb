# encoding: utf-8
module Alchemist
  class Avatar
    attr_reader :name, :x, :y

    def initialize(name, x = 0, y = 0)
      @name = name
      @x = x.to_i
      @y = y.to_i
    end

    def move(direction, max_x, max_y)
      Avatar.new name, *direction.move_from(x, y, max_x, max_y)
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
      "⚲ #{name} #{x} #{y}"
    end

    def self.parse(string)
      if string =~ /^⚲ (.*)$/
        new *$1.split(" ")
      end
    end
  end
end

