module Alchemist
  module Commands
    class Inventory < Base
      pattern "inv(entory)?"

      def run
        outcome "inventory #{history.world.avatar(avatar_name).inventory}"
      end
    end
  end
end

