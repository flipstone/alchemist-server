module Alchemist
  module Commands
    class DirectionCommand < Base
      def run
        world = history.world.move avatar_name, direction

        return "location #{world.location(avatar_name)}",
               world
      end
    end

    class North < DirectionCommand
      pattern 'north'

      def direction
        Direction::North
      end
    end

    class South < DirectionCommand
      pattern 'south'

      def direction
        Direction::South
      end
    end

    class East < DirectionCommand
      pattern 'east'

      def direction
        Direction::East
      end
    end

    class West < DirectionCommand
      pattern 'west'

      def direction
        Direction::West
      end
    end
  end
end


