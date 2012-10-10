module Alchemist
  module Commands
    module Location
      class <<self
        def pattern
          "loc(ation)?"
        end

        def run(avatar_name, history)
          history.world.location(avatar_name).to_s
        end
      end
    end
  end
end
