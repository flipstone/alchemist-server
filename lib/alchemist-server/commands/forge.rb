module Alchemist
  module Commands
    module Forge
      class <<self
        def pattern
          "forg(e)?"
        end

        def run(avatar_name, history, elem_1, elem_2, novel_elem)
          world = history.world.forge avatar_name,
                                      elem_1,
                                      elem_2,
                                      novel_elem
          a = world.avatar avatar_name

          return "#{avatar_name}'s Inventory: #{a.inventory}",
                 world
        end
      end
    end
  end
end
