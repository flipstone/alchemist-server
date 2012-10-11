# encoding: utf-8
module Alchemist
  class Avatar
    INVENTORY_SIZE = 64

    include Record
    record_attr :name, :x, :y, :inventory, :messages

    def move(direction)
      new_x, new_y = direction.move_from(x, y)
      update x: new_x, y: new_y
    end

    def location
      Geography::Loc.new x, y
    end

    def add_to_inventory(additions)
      a = update inventory: (inventory + additions).gsub(' ','')

      if a.inventory.length > INVENTORY_SIZE
        raise "You can only carry #{INVENTORY_SIZE} items"
      end

      a
    end

    def remove_from_inventory(*removals)
      remover = removals.join('').split('').reduce(-> x { x }) do |r, c|
        -> x { r[x].sub(c,'') }
      end

      update inventory: remover[inventory]
    end

    def put_message(key, message)
      if key.to_s =~ /^[0-9]$/
        update messages: messages.put(key.to_s.to_i, message)
      else
        raise "Only 0 through 9 may be used as message keys"
      end
    end

    def message_list
      messages.keys.sort.map { |k| messages[k] }
    end

    def has?(*items)
      items.all? { |i| inventory.include? i }
    end

    def hash
      name.hash
    end

    def ==(other)
      other.class == self.class &&
      other.name == name
    end

    def eql?(other)
      self == other
    end

    def to_s
      "⚲ #{name} #{x} #{y} #{inventory}"
    end

    def self.parse(string)
      if string =~ /^⚲ (.*)$/
        new *$1.split(" ")
      end
    end
  end
end

