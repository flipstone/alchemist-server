module Alchemist
  module Commands
    module Take
      class <<self
        def pattern
          "take"
        end

        def run(avatar_name, history)
          world = history.world.take(avatar_name)
          a = world.avatar avatar_name

          return "inventory #{a.inventory}",
                 world
        end
      end
    end
  end
end
