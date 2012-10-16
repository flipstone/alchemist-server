module Alchemist
  module Commands
    class Who < Base
      pattern "who"

      def run
        a = history.world.avatar avatar_name
        avatars = history.world.nearby_avatars a

        locations = avatars.map do |avatar|
          "avatar #{avatar.name} #{avatar.x} #{avatar.y}\n"
        end.join('')

        outcome locations
      end
    end
  end
end
