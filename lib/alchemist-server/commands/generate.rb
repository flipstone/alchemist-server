module Alchemist
  module Commands
    module Generate
      class <<self
        def pattern
          "gen(erate)?"
        end

        def run(history, x, y)
          w = World.new [], y.to_i.times.map { ee(x.to_i) }.join("\n")
          return w.geography, w
        end

        def ee(n)
          n.times.map {e}.join ''
        end

        def e
          INITIAL_ELEMENTS.shuffle.first
        end

        INITIAL_ELEMENTS = %w(^ ~ -)
      end
    end
  end
end
