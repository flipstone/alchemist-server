module Alchemist
  module Commands
    module Message
      class <<self
        def pattern
          "message|msg"
        end

        def run(avatar_name, history, key, *words)
          world = history.world.put_message avatar_name,
                                            key,
                                            words.join(' ')

          return "Message posted.", world
        end
      end
    end
  end
end
