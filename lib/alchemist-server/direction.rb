module Alchemist
  module Direction
    module South
      def self.move_from(x, y, max_x, max_y)
        [x, [y + 1, max_y].min]
      end
    end
  end
end
