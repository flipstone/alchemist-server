module Alchemist
  module Commands
    module Geography
      class <<self
        def pattern
          "geo(graphy)?"
        end

        def run(avatar_name, history)
          history.world.geography
        end
      end
    end
  end
end
