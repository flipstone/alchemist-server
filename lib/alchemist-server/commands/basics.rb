module Alchemist
  module Commands
    class Basics < Base
      pattern "basics"

      def run
        elements = history.world.basic_elements
        outcome "basics #{elements.map(&:symbol).join('')}"
      end
    end
  end
end
