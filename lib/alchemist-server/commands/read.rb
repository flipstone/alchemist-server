module Alchemist
  module Commands
    class Read < Base
      pattern "read"

      def run
        messages = history.world.messages_for avatar_name

        lines = messages.flat_map do |name, messages|
          ["#{name}:"] + messages + ['']
        end

        [ "messages #{lines.length}" ] + lines.join("\n")
      end
    end
  end
end

