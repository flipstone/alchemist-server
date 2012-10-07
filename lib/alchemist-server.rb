require "time"
require "hamster"

require "alchemist-server/version"

require "alchemist-server/avatar"
require "alchemist-server/commands/appear"
require "alchemist-server/commands/generate"
require "alchemist-server/commands/south"
require "alchemist-server/direction"
require "alchemist-server/event"
require "alchemist-server/world"
require "alchemist-server/world_history"

class Object
  def try(sym, *args)
    send sym, *args
  end
end

class NilClass
  def try(*args)

  end
end

module Alchemist
  module Server
    def self.one_shot(world_file, command_string)
      command, *args = command_string.split /\s+/

      if command_mod = COMMANDS.detect { |c| match_command? command, c }
        run_command_module command_string, world_file, command_mod, *args
      else
        run_special_command world_file, command, *args
      end
    end

    def self.run_command_module(command_string, world_file, command_mod, *args)
      history = load_history world_file
      response, new_world = command_mod.run history, *args
      event = Event.new command_string, new_world, Time.now
      new_history = WorldHistory.new event, history

      File.open(world_file,'w') do |f|
        f.write new_history.to_s
      end

      response
    end

    def self.run_special_command(world_file, command_string, *args)
      case command_string
      when /^show_raw_file$/
        File.read(world_file)
      when /^show_history$/
        load_history(world_file).to_s
      when /^loc(ation)?$/
        load_history(world_file).world.location(*args).to_s
      when /^dim(ensions)?$/
        load_history(world_file).world.dimensions(*args).to_s
      else
        "Unknown Command: #{command}"
      end
    end

    def self.load_history(file_name)
      if File.exist? file_name
        WorldHistory.parse File.read(file_name)
      else
        nil
      end
    end

    def self.match_command?(command_name, command)
      command_name =~ /^#{command.pattern}/
    end
  end

  COMMANDS = [
    Commands::Appear,
    Commands::Generate,
    Commands::South
  ]
end

