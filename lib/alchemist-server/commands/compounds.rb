module Alchemist
  module Commands
    class Compounds < Base
      pattern "compounds"

      def run
        elements = history.world.compound_elements
        "compounds #{elements.map(&:symbol).join('')}"
      end
    end
  end
end

