module Alchemist
  module Direction
    module North
      def self.move_from(x, y, width, height)
        [x, [y - 1, 0].max]
      end
    end

    module South
      def self.move_from(x, y, width, height)
        [x, [y + 1, height - 1].min]
      end
    end

    module East
      def self.move_from(x, y, width, height)
        [[x + 1, width - 1].min, y]
      end
    end

    module West
      def self.move_from(x, y, width, height)
        [[x - 1, 0].max, y]
      end
    end
  end
end

