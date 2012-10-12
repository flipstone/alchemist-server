module Alchemist
  module ServerHandler
    def self.new(world_file)
      Module.new do
        include Methods

        @world_file = world_file

        def self.included(mod)
          mod.instance_variable_set :@world_file, @world_file
          def mod.world_file; @world_file; end
        end

        def world_file
          self.class.world_file
        end
      end
    end

    module Methods
      include EventMachine::Protocols::LineProtocol

      def post_init
        send_line "Welcome, alchemical friend. What is your name?"
      end

      def receive_line(line)
        response = process_line line

        if response
          send_line "response-to: #{line.split(' ').first.chomp}"
          send_line response
          send_line "response-end"
        end
      end

      def process_line(line)
        if @name
          command = "#{@name} #{line.chomp}"
          Alchemist::Server.one_shot world_file, command
        else
          possible_name = line.strip.split(' ').first

          if possible_name && possible_name.length > 0
            @name = possible_name
            "Greetings, #{@name}."
          else
            "Please tell me your name."
          end
        end
      rescue => e
        $stderr.puts "#{e.class}: #{e.message}"
        $stderr.puts e.backtrace
        "Error: #{e}"
      end

      def send_line(data)
        send_data data
        send_data "\n"
      end
    end
  end
end

