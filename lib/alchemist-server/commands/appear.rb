module Alchemist
  module Commands
    module Appear
      class <<self
        def pattern
          "app(ear)?"
        end

        def run(avatar_name, history)
          return "#{avatar_name} has appeared in the world.",
                 history.world.new_avatar(avatar_name)
        end
      end
    end
  end
end
