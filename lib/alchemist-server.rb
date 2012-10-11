require "time"
require "hamster"
require "socket"
require "eventmachine"
require "em/protocols/line_protocol"

require "alchemist-server/version"

require "alchemist-server/avatar"
require "alchemist-server/direction"
require "alchemist-server/event"
require "alchemist-server/formula"
require "alchemist-server/geography"
require "alchemist-server/server_handler"
require "alchemist-server/world"
require "alchemist-server/world_history"

require "alchemist-server/commands/appear"
require "alchemist-server/commands/create"
require "alchemist-server/commands/directions"
require "alchemist-server/commands/forge"
require "alchemist-server/commands/formulate"
require "alchemist-server/commands/geography"
require "alchemist-server/commands/inventory"
require "alchemist-server/commands/location"
require "alchemist-server/commands/look"
require "alchemist-server/commands/put"
require "alchemist-server/commands/take"

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
    SERVER_PORT = 79 * 100

    def self.run(world_file)
      EventMachine.start_server "", SERVER_PORT, ServerHandler.new(world_file)
      puts "Listening on #{SERVER_PORT}"
    end

    def self.one_shot(world_file, command_string)
      avatar_name, command, *args = command_string.split /\s+/

      if command_mod = COMMANDS.detect { |c| match_command? command, c }
        run_command_module command_string, world_file, command_mod
      else
        run_special_command world_file, command, *args
      end
    end

    def self.run_command_module(command_string, world_file, command_mod)
      history = load_history world_file
      event = Event.new command_string, Time.now
      response, new_world = event.happen history

      if new_world
        new_history = WorldHistory.new event, history

        File.open(world_file,'w') do |f|
          f.write new_history.to_s
        end
      end

      response
    end

    def self.run_special_command(world_file, command_string, *args)
      case command_string
      when /^show_raw_file$/
        File.read(world_file)
      when /^show_history$/
        load_history(world_file).to_s
      when /^dim(ensions)?$/
        load_history(world_file).world.dimensions(*args).to_s
      else
        "Unknown Command: #{command_string}"
      end
    end

    def self.load_history(file_name)
      if File.exist? file_name
        WorldHistory.parse File.read(file_name)
      else
        WorldHistory.genesis
      end
    end

    def self.match_command?(command_name, command)
      command_name =~ /^#{command.pattern}/
    end
  end

  COMMANDS = [
    Commands::Appear,
    Commands::Create,
    Commands::North,
    Commands::South,
    Commands::East,
    Commands::West,
    Commands::Inventory,
    Commands::Forge,
    Commands::Formulate,
    Commands::Geography,
    Commands::Location,
    Commands::Look,
    Commands::Put,
    Commands::Take,
  ]
end

