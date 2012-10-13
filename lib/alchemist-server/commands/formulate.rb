module Alchemist
  module Commands
    module Formulate
      class <<self
        def pattern
          "form(ulate)?"
        end

        def run(avatar_name, history, elem_1, elem_2, novel_elem, *name)
          world = history.world.formulate avatar_name,
                                          elem_1,
                                          elem_2,
                                          novel_elem,
                                          name.join(' ')
          a = world.avatar avatar_name

          return "inventory #{a.inventory}",
                 world
        end
      end
    end
  end
end
