module Alchemist
  module Commands
    class DirectionCommand
      attr_reader :pattern

      def initialize(pattern, direction)
        @pattern = pattern
        @direction = direction
      end

      def run(avatar_name, history)
        world = history.world.move avatar_name, @direction

        return "location #{world.location(avatar_name)}",
               world
      end
    end

    North = DirectionCommand.new 'north', Direction::North
    South = DirectionCommand.new 'south', Direction::South
    East  = DirectionCommand.new 'east',  Direction::East
    West  = DirectionCommand.new 'west',  Direction::West
  end
end

