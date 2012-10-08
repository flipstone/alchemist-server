module Alchemist
  module Commands
    module Take
      class <<self
        def pattern
          "take"
        end

        def run(world_history, avatar_name)
          world = world_history.world.take(avatar_name)
          a = world.avatar avatar_name

          return "#{avatar_name}'s Inventory: #{a.try :inventory}",
                 world
        end
      end
    end
  end
end
