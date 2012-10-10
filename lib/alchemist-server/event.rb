module Alchemist
  class Event
    attr_reader :command_string

    def initialize(command_string, time)
      @command_string = command_string
      @time = time
    end

    def happen(history)
      avatar_name, command, *args = @command_string.split /\s+/

      if command_mod = COMMANDS.detect { |c| match_command? command, c }
        command_mod.run avatar_name, history, *args
      end
    end

    def to_s
      <<-str
#{@command_string}
#{@time}
      str
    end

    protected

    def match_command?(command_name, command)
      command_name =~ /^#{command.pattern}/
    end

    def self.parse(string)
      command_string, time, world_string = string.split("\n",3)
      new command_string, Time.parse(time)
    end

    def self.genesis
      new 'genesis', Time.now
    end
  end
end

