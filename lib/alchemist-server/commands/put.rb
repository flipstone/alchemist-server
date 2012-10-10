module Alchemist
  module Commands
    module Put
      class <<self
        def pattern
          "put"
        end

        def run(world_history, avatar_name, resource)
          world = world_history.world.put avatar_name, resource
          a = world.avatar avatar_name

          return "#{avatar_name}'s Inventory: #{a.try :inventory}",
                 world
        end
      end
    end
  end
end
