module Alchemist
  module Commands
    module Read
      class <<self
        def pattern
          "read"
        end

        def run(avatar_name, history)
          messages = history.world.messages_for avatar_name

          messages.flat_map do |name, messages|
            ["#{name}:"] + messages + ['']
          end.join("\n")
        end
      end
    end
  end
end
