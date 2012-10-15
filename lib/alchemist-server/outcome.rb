module Alchemist
  class Outcome
    include Record
    include Enumerable

    record_attr :response,
                :new_world,
                :new_history
  end
end

