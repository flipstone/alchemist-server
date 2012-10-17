module Alchemist
  module Commands
    class Who < Base
      pattern "who"

      def run
        a = history.world.avatar avatar_name
        avatars = history.world.nearby_avatars a

        locations = avatars.map do |avatar|
          "#{avatar.name} #{avatar.x} #{avatar.y}\n"
        end

        outcome (["avatars #{locations.length}\n"] + locations).join('')
      end
    end
  end
end
