module Alchemist
  module Commands
    class Message < Base
      pattern "message|msg"

      def run(key, *words)
        world = history.world.put_message avatar_name,
                                          key,
                                          words.join(' ')

        outcome "posted", world
      end
    end
  end
end
