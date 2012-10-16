module Alchemist
  module Commands
    class Location < Base
      pattern "location"

      def run
        x, y = history.world.location avatar_name
        outcome "location #{x} #{y}"
      end
    end
  end
end

