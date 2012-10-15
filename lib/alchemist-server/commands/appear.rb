module Alchemist
  module Commands
    class Appear < Base
      pattern "app(ear)?"

      def run
        return "appeared",
               history.world.new_avatar(avatar_name)
      end
    end
  end
end
