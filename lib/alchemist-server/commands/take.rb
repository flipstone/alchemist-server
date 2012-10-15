module Alchemist
  module Commands
    class Take < Base
      pattern "take"

      def run
        world = history.world.take(avatar_name)
        a = world.avatar avatar_name

        outcome "inventory #{a.inventory}",
                world
      end
    end
  end
end

