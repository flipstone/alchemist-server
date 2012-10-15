module Alchemist
  module Commands
    class Base
      def self.pattern(arg = nil)
        if arg
          @pattern = arg
        end

        @pattern
      end

      attr_reader :avatar_name, :history

      def initialize(avatar_name, history)
        @avatar_name = avatar_name
        @history = history
      end

      def outcome(response = nil, new_world = nil)
        Outcome.new response: response,
                    new_world: new_world
      end

      def self.run(avatar_name, history, *args)
        new(avatar_name, history).run *args
      end
    end
  end
end

