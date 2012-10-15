module Alchemist
  module Commands
    class Basics < Base
      pattern "basics"

      def run
        elements = history.world.basic_elements
        "basics #{elements.map(&:symbol).join('')}"
      end
    end
  end
end
