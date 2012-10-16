module Alchemist
  class Geography
    def initialize(locations = {})
      @locations = case locations
                   when Hamster::Hash then locations
                   else Hamster.hash locations
                   end
    end

    def at(x,y)
      locations[Loc[x,y]]
    end

    def take(x,y)
      Geography.new locations.delete(Loc[x,y])
    end

    def put(x,y,c)
      loc = Loc[x,y]

      if locations.key? loc
        raise "#{locations[loc]} is already at #{x},#{y}"
      end

      Geography.new locations.put(loc, c[0..1])
    end

    def string_around(x,y,range)
      string_within x - range,
                    y - range,
                    x + range,
                    y + range
    end

    def to_s
      (min_x, min_y), (max_x, max_y) = dimensions
      string_within min_x, min_y, max_x, max_y
    end

    def string_within(min_x, min_y, max_x, max_y)
      if min_x && min_y && max_x && max_y
        (min_y..max_y).map do |y|
          (min_x..max_x).map do |x|
            at(x, y) || ' '
          end.join('')
        end.join("\n")
      else
        ''
      end
    end


    def dimensions
      points = locations.keys
      xs,ys = points.map(&:x), points.map(&:y)

      [[xs.min, ys.min],[xs.max,ys.max]]
    end

    private

    def locations
      @locations
    end

    def offset(x,y)
      w,h = dimensions
      y*(w + 1) + x
    end

    class Loc
      attr_reader :x, :y

      def self.[](*args)
        new *args
      end

      def initialize(x,y)
        @x = x
        @y = y
      end

      def hash
        (@x.hash * 31) + @y.hash
      end

      def within?(min, max)
        min.x <= x && x <= max.x &&
        min.y <= y && y <= max.y
      end

      def distance(loc)
        [
          (loc.x - x).abs,
          (loc.y - y).abs
        ].min
      end

      def ==(other)
        other.class == self.class &&
        other.x == x &&
        other.y == y
      end

      def eql?(other)
        self == other
      end
    end
  end
end

