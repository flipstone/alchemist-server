require "time"
require "hamster"

require "alchemist-server/version"

require "alchemist-server/avatar"
require "alchemist-server/event"
require "alchemist-server/world"
require "alchemist-server/world_history"

module Alchemist
  module Server
    def self.one_shot(world_file, command_string)
      command, *args = command_string.split /\s+/

      case command
      when /^gen(erate)?$/
        history = load_history world_file
        new_world, response = generate *args.map(&:to_i)
        event = Event.new command_string, new_world, Time.now
        new_history = WorldHistory.new event, history

        File.open(world_file,'w') do |f|
          f.write new_history.to_s
        end

        response
      when /^app(ear)?$/
        history = load_history world_file
        new_world, response = appear history.world, *args
        event = Event.new command_string, new_world, Time.now
        new_history = WorldHistory.new event, history

        File.open(world_file,'w') do |f|
          f.write new_history.to_s
        end

        response
      when /^show_raw_file$/
        _, response = show_raw_file world_file
        response
      when /^show_history$/
        load_history(world_file).to_s
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

    def self.show_raw_file(world_file)
      return nil, File.read(world_file)
    end

    def self.generate(x, y)
      w = World.new [], y.times.map { ee(x) }.join("\n")
      return w, w.geography
    end

    def self.appear(world, avatar_name)
      return world.new_avatar(avatar_name), "Greetings, #{avatar_name}."
    end

    def self.ee(n)
      n.times.map {e}.join ''
    end

    def self.e
      INITIAL_ELEMENTS.shuffle.first
    end

    INITIAL_ELEMENTS = %w(^ ~ -)
  end
end

