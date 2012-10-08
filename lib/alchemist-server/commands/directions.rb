module Alchemist
  module Commands
    class DirectionCommand
      attr_reader :pattern

      def initialize(pattern, direction)
        @pattern = pattern
        @direction = direction
      end

      def run(history, avatar_name)
        world = history.world.move avatar_name, @direction

        return "#{avatar_name} is now at #{world.location(avatar_name)}",
               world
      end
    end

    North = DirectionCommand.new 'north', Direction::North
    South = DirectionCommand.new 'south', Direction::South
    East  = DirectionCommand.new 'east',  Direction::East
    West  = DirectionCommand.new 'west',  Direction::West
  end
end

