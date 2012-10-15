module Alchemist
  module Commands
    class Look < Base
      pattern "look"

      def run
        [
          "see #{World::LOOK_RANGE*2}",
          history.world.look(avatar_name)
        ].join("\n")
      end
    end
  end
end
