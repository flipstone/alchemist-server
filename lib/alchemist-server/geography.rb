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

    def to_s
      (min_x, max_x), (min_y, max_y) = dimensions

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

      [[xs.min, xs.max],[ys.min,ys.max]]
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

