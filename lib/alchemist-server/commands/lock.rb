module Alchemist
  module Commands
    class Lock < Base
      pattern "lock"

      def run
        return "locked", history.world.lock
      end
    end
  end
end

