module Alchemist
  module Commands
    module Compounds
      class <<self
        def pattern
          "compounds"
        end

        def run(avatar_name, history)
          elements = history.world.compound_elements
          "compounds #{elements.map(&:symbol).join('')}"
        end
      end
    end
  end
end
