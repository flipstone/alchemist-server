module Alchemist
  class World
    include Record
    LOOK_RANGE = 10
    record_attr :avatars,
                :formulas,
                :geography,
                :elements,
                :locked

    def to_s
      (avatars.to_a.map(&:to_s) + [geography]).join("\n")
    end

    def new_avatar(name)
      a = Avatar.new name: name,
                     x: 0,
                     y: 0,
                     inventory: "",
                     messages: Hamster.hash

      if !avatars.include? a
        update avatars: avatars | [a]
      end
    end

    def nearby_avatar_names(name)
      nearby_avatars(avatar(name)).map &:name
    end

    def nearby_avatars(a)
      avatars.select do |avatar|
        avatar.near? a.location, LOOK_RANGE
      end
    end

    def lock
      raise "The world is already locked" if locked
      update locked: true
    end

    LOCKED_MESSAGE = "New basic elements can no longer be created. Try creating a compound instead"
    def new_element(char, name)
      raise LOCKED_MESSAGE if locked

      e = Element.new symbol: char, name: name, basic: true

      update elements: elements.put(char, e)
    end

    def formulate(avatar_name, elem_1, elem_2, novel_elem, name)
      if formulas[novel_elem]
        raise "There is already a formula for #{novel_elem}"

      elsif elements[novel_elem]
        raise "#{novel_elem} is a basic element!"

      else
        f = Formula.new elem_1, elem_2, novel_elem
        e = Element.new symbol: novel_elem,
                        name: name,
                        basic: false

        w = update formulas: formulas.put(novel_elem, f),
                   elements: elements.put(novel_elem, e)

        w.forge(avatar_name, elem_1, elem_2, novel_elem)
      end
    end

    def forge(avatar_name, elem_1, elem_2, result)
      a = avatar avatar_name

      if !a.has?(elem_1, elem_2)
        raise "#{avatar_name} doesn't have the required elements"
      end

      f = Formula.new elem_1, elem_2, result

      if formulas[result] == f
        a_temp = a.remove_from_inventory elem_1, elem_2
        a_prime = a_temp.add_to_inventory result

        update avatars: avatars - [a] + [a_prime]
      else
        raise "Incorrect formula for #{result}"
      end
    end

    def avatar(name)
      avatars.detect { |a| a.name == name } ||
      raise("#{name} isn't in the world")
    end

    def at(avatar_name)
      a = avatar(avatar_name)
      geography.at a.x, a.y
    end

    def look(avatar_name)
      a = avatar(avatar_name)
      geography.string_around a.x, a.y, LOOK_RANGE
    end

    def take(avatar_name)
      a = avatar(avatar_name)

      resource = geography.at a.x, a.y
      new_a = a.add_to_inventory resource
      new_g = geography.take a.x, a.y

      update avatars: avatars - [a] + [new_a],
             geography: new_g
    end

    def put(avatar_name, c)
      a = avatar(avatar_name)

      if a.has? c
        new_g = geography.put a.x, a.y, c
        new_a = a.remove_from_inventory c

        update avatars: avatars - [a] + [new_a],
               geography: new_g
      else
        raise "#{avatar_name} doesn't have #{c}"
      end
    end

    def create(avatar_name, c)
      a = avatar(avatar_name)
      new_a = a.add_to_inventory c

      element = elements[c]

      if element.nil?
        raise "Unknown element: #{c}."
      elsif !element.basic
        raise "#{c} is not a basic element."
      end

      update avatars: avatars - [a] + [new_a]
    end

    def move(avatar_name, direction)
      a = avatar(avatar_name)
      a_prime = a.move direction

      update avatars: avatars - [a] + [a_prime]
    end

    def put_message(avatar_name, key, message)
      a = avatar(avatar_name)
      a_prime = a.put_message key, message

      update avatars: avatars - [a] + [a_prime]
    end

    def messages_for(avatar_name)
      a = avatar(avatar_name)
      messengers = nearby_avatars a

      messengers.sort_by(&:name).map do |m|
        { m.name => m.message_list }
      end.reduce({}, :merge)
    end

    def location(avatar_name)
      a = avatar avatar_name
      [a.x, a.y]
    end

    def dimensions
      geography.dimensions
    end

    def basic_elements
      elements.values.select(&:basic?)
    end

    def compound_elements
      elements.values.reject(&:basic?)
    end

    def self.genesis
      World.new avatars: [],
                formulas: Hamster.hash,
                geography: Geography.new,
                elements: Hamster.hash
    end
  end
end

