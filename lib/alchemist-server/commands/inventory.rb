module Alchemist
  module Commands
    module Inventory
      class <<self
        def pattern
          "inv(entory)?"
        end

        def run(world_history, avatar_name)
          world_history.world.avatar(avatar_name).try :inventory
        end
      end
    end
  end
end
