module Alchemist
  module Commands
    module Lock
      class <<self
        def pattern
          "lock"
        end

        def run(avatar_name, history)
          return "locked", history.world.lock
        end
      end
    end
  end
end
