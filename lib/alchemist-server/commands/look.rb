module Alchemist
  module Commands
    module Look
      class <<self
        def pattern
          "look"
        end

        def run(avatar_name, history)
          history.world.at avatar_name
        end
      end
    end
  end
end
