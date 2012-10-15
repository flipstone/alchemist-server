module Alchemist
  module Commands
    class Lock < Base
      pattern "lock"

      def run
        outcome "locked", history.world.lock
      end
    end
  end
end

