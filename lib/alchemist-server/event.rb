module Alchemist
  class Event
    def initialize(command, new_world, time)
      @command = command
      @new_world = new_world
      @time = time
    end

    def to_s
      <<-str
#{@command}
#{@time}
#{@new_world}
      str
    end

    def self.parse(string)
      command, time, world_string = string.split("\n",3)
      new command, World.parse(world_string), Time.parse(time)
    end
  end
end

