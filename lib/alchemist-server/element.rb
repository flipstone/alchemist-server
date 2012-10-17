module Alchemist
  class Element
    include Record
    record_attr :symbol, :name, :basic

    def basic?
      basic
    end

    def hex_code
      "0x#{symbol.ord.to_s(16)}"
    end
  end
end
