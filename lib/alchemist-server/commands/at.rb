module Alchemist
  module Commands
    module At
      class <<self
        def pattern
          "at"
        end

        def run(history, avatar_name)
          history.world.at avatar_name
        end
      end
    end
  end
end
