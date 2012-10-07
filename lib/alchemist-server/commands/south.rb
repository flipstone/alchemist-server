module Alchemist
  module Commands
    module South
      class <<self
        def pattern
          "south"
        end

        def run(history, avatar_name)
          world = history.world.move avatar_name, Direction::South

          return "#{avatar_name} is now at #{world.location(avatar_name)}",
                 world
        end
      end
    end
  end
end
