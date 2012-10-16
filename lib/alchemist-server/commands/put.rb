module Alchemist
  module Commands
    class Put < Base
      pattern "put"

      def run(resource)
        world = history.world.put avatar_name, resource
        a = world.avatar avatar_name

        outcome "inventory #{a.inventory}",
                world,
                Commands::Look
      end
    end
  end
end
