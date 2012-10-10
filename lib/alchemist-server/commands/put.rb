module Alchemist
  module Commands
    module Put
      class <<self
        def pattern
          "put"
        end

        def run(avatar_name, history, resource)
          world = history.world.put avatar_name, resource
          a = world.avatar avatar_name

          return "#{avatar_name}'s Inventory: #{a.try :inventory}",
                 world
        end
      end
    end
  end
end
