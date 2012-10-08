module Alchemist
  module Commands
    module Geography
      class <<self
        def pattern
          "geo(graphy)?"
        end

        def run(world_history)
          world_history.world.geography
        end
      end
    end
  end
end