module Alchemist
  module Commands
    module Inventory
      class <<self
        def pattern
          "inv(entory)?"
        end

        def run(avatar_name, history)
          "inventory #{history.world.avatar(avatar_name).inventory}"
        end
      end
    end
  end
end
