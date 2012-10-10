module Alchemist
  module Direction
    module North
      def self.move_from(x, y)
        [x, y - 1]
      end
    end

    module South
      def self.move_from(x, y)
        [x, y + 1]
      end
    end

    module East
      def self.move_from(x, y)
        [x + 1, y]
      end
    end

    module West
      def self.move_from(x, y)
        [x - 1, y]
      end
    end
  end
end

