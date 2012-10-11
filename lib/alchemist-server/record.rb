module Alchemist
  module Record
    def self.included(mod)
      mod.extend ClassMethods
    end

    def initialize(attrs = {})
      @attrs = Record.hamsterize(attrs).slice(*attr_names)
    end

    def update(attr_changes)
      self.class.new @attrs.merge(Record.hamsterize(attr_changes))
    end

    def read(attr)
      @attrs[attr]
    end

    def attr_names
      self.class.attr_names
    end

    def self.hamsterize(hash)
      case hash
      when Hamster::Hash then hash
      else Hamster.hash hash
      end
    end

    module ClassMethods
      def attr_names
        @attr_names ||= []
      end

      def attr_names=(attrs)
        @attr_names = attrs
      end

      def record_attr(*attrs)
        attrs.each do |attr|
          class_eval %{
            def #{attr}
              read :#{attr}
            end
          }
        end
        self.attr_names += attrs
      end
    end
  end
end
