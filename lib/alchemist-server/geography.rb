module Alchemist
  class Geography
    def initialize(geo_string)
      @s = geo_string
    end

    def at(x,y)
      @s[offset(x,y)]
    end

    def take(x,y)
      s = @s.dup
      s[offset(x,y)] = ' '
      Geography.new s
    end

    def put(x,y,c)
      s = @s.dup
      if s[offset(x,y)] != ' '
        raise "#{s[offset(x,y)]} is already at #{x}, #{y}"
      end

      s[offset(x,y)] = c[0..1]
      Geography.new s
    end

    def to_s
      @s
    end

    def dimensions
      lines = @s.lines.map(&:chomp)
      [lines.first.length, lines.length]
    end

    private

    def offset(x,y)
      w,h = dimensions
      y*(w + 1) + x
    end
  end
end

