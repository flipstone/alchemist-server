module Alchemist
  module Commands
    class Formulate < Base
      pattern "form(ulate)?"

      def run(elem_1, elem_2, novel_elem, *name)
        world = history.world.formulate avatar_name,
                                        elem_1,
                                        elem_2,
                                        novel_elem,
                                        name.join(' ')
        a = world.avatar avatar_name

        outcome "inventory #{a.inventory}",
                world
      end
    end
  end
end
