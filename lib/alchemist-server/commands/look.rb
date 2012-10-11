module Alchemist
  module Commands
    module Look
      class <<self
        def pattern
          "look"
        end

        def run(avatar_name, history)
          history.world.look(avatar_name)
        end
      end
    end
  end
end
