module Alchemist
  module Commands
    class Describe < Base
      pattern "describe"

      def run(symbol)
        element = history.world.element symbol

        if element
          outcome "element #{element.symbol} #{element.name}"
        else
          outcome "noelement #{symbol}"
        end
      end
    end
  end
end

