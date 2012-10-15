module Alchemist
  module Commands
    class Create < Base
      pattern "create"

      def run(resource)
        world = history.world.create avatar_name, resource
        a = world.avatar avatar_name

        outcome "inventory #{a.try :inventory}",
                world
      end
    end
  end
end

