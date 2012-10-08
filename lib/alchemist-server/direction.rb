module Alchemist
  module Direction
    module North
      def self.move_from(x, y, max_x, max_y)
        [x, [y - 1, 0].max]
      end
    end

    module South
      def self.move_from(x, y, max_x, max_y)
        [x, [y + 1, max_y].min]
      end
    end

    module East
      def self.move_from(x, y, max_x, max_y)
        [[x - 1, 0].max, y]
      end
    end

    module West
      def self.move_from(x, y, max_x, max_y)
        [[x + 1, max_x].min, y]
      end
    end
  end
end
