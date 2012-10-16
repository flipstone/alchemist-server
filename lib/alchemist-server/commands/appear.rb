module Alchemist
  module Commands
    class Appear < Base
      pattern "app(ear)?"

      def run
        outcome "appeared",
                history.world.new_avatar(avatar_name),
                Commands::Who
      end
    end
  end
end
