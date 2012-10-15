module Alchemist
  module Commands
    class Element < Base
      pattern "el(ement)?"

      def run(char, *name)
        world = history.world.new_element char, name.join(' ')

        outcome "element #{char}.", world
      end
    end
  end
end

