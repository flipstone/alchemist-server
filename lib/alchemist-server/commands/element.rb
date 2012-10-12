module Alchemist
  module Commands
    module Element
      class <<self
        def pattern
          "el(ement)?"
        end

        def run(avatar_name, history, char, name)
          world = history.world.new_element char, name

          return "element #{char}.", world
        end
      end
    end
  end
end
