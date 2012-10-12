module Alchemist
  module Commands
    module Basics
      class <<self
        def pattern
          "basics"
        end

        def run(avatar_name, history)
          elements = history.world.basic_elements
          "basics #{elements.map(&:symbol).join('')}"
        end
      end
    end
  end
end
