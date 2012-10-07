module Alchemist
  module Commands
    module Appear
      class <<self
        def pattern
          "app(ear)?"
        end

        def run(history, avatar_name)
          return "Greetings, #{avatar_name}.",
                 history.world.new_avatar(avatar_name)
        end
      end
    end
  end
end
