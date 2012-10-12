module Alchemist
  class Element
    include Record
    record_attr :symbol, :name, :basic

    def basic?
      basic
    end
  end
end
