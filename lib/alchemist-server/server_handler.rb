module Alchemist
  module ServerHandler
    def self.new(world_file)
      puts "Loading history...."
      history = Alchemist::Server.load_history world_file

      Module.new do
        include Methods

        @world_file = world_file
        @history = history
        @connections = []

        class <<self
          attr_reader :world_file
          attr_accessor :history
          attr_accessor :connections
        end

        def self.included(mod)
          mod.instance_variable_set :@state, self
          def mod.state; @state; end
        end

        def world_file
          self.class.state.world_file
        end

        def history
          self.class.state.history
        end

        def history=(h)
          self.class.state.history = h
        end

        def connections
          self.class.state.connections
        end
      end
    end

    module Methods
      include ::EventMachine::Protocols::LineProtocol

      attr_reader :name

      def post_init
        connections << self
        send_line "Welcome alchemical friend. What is your name?"
      end

      def unbind
        connections.delete self
      end

      def receive_line(line)
        t = Benchmark.realtime do
          response = process_line line

          if response
            send_line response
          end
        end

        puts "#{Time.now} #{line.split(' ').first} #{(t*1000).round}"
      end

      def process_line(line)
        if name
          command = "#{name} #{line.chomp}"
          outcome = Alchemist::Server.run_append command,
                                                 world_file,
                                                 history

          self.history = outcome.new_history if outcome.new_history

          if command = outcome.nearby_avatar_command
            run_command_nearby command
          end

          outcome.response
        else
          possible_name = line.strip.split(' ').first

          if possible_name && possible_name.length > 0
            @name = possible_name
            "hello #{name}"
          else
            "Please tell me your name."
          end
        end
      rescue => e
        show_error e
        "error #{e}"
      end

      def run_command_nearby(command)
        new_nearby = history.world.nearby_avatar_names name
        old_nearby = begin
                       history.prior_world.try :nearby_avatar_names, name
                     rescue
                       # bail out if user wasn't in prior world
                       []
                     end

        nearby = new_nearby | (old_nearby || [])

        connections.select do |c|
          begin
            if nearby.include? c.name
              c.run_unrecorded_command command
            end
          rescue => e
            show_error e
          end
        end
      end

      def show_error(e)
        $stderr.puts "#{e.class}: #{e.message}"
        $stderr.puts e.backtrace
      end

      def run_unrecorded_command(command)
        outcome = command.run name, history

        if r = outcome.response
          send_line r
        end
      end

      def send_line(data)
        send_data data

        if data[-1] != "\n"
          send_data "\n"
        end
      end
    end
  end
end

