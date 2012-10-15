module Alchemist
  module Commands
    class Location < Base
      pattern "location"

      def run
        outcome "location #{history.world.location(avatar_name).to_s}"
      end
    end
  end
end

