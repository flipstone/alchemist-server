module Alchemist
  module Commands
    module Look
      class <<self
        def pattern
          "look"
        end

        def run(avatar_name, history)
          [
            "see #{World::LOOK_RANGE*2}",
            history.world.look(avatar_name)
          ].join("\n")
        end
      end
    end
  end
end
