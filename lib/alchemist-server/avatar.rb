# encoding: utf-8
module Alchemist
  class Avatar
    attr_reader :name

    def initialize(name)
      @name = name
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
      "⚲ #{name}"
    end

    def self.parse(string)
      if string =~ /^⚲ (.*)$/
        new $1
      end
    end
  end
end

