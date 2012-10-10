module Alchemist
  module Commands
    module Create
      class <<self
        def pattern
          "create"
        end

        def run(avatar_name, history, resource)
          world = history.world.create avatar_name, resource
          a = world.avatar avatar_name

          return "#{avatar_name}'s Inventory: #{a.try :inventory}",
                 world
        end
      end
    end
  end
end
