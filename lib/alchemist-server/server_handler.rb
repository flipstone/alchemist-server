module Alchemist
  module ServerHandler
    def self.new(world_file)
      puts "Loading history...."
      history = Alchemist::Server.load_history world_file

      Module.new do
        include Methods

        @world_file = world_file
        @history = history

        class <<self
          attr_reader :world_file
          attr_accessor :history
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
      end
    end

    module Methods
      include EventMachine::Protocols::LineProtocol

      def post_init
        send_line "Welcome, alchemical friend. What is your name?"
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
        if @name
          command = "#{@name} #{line.chomp}"
          res, new_h = Alchemist::Server.run_append command,
                                                    world_file,
                                                    history

          self.history = new_h if new_h
          res
        else
          possible_name = line.strip.split(' ').first

          if possible_name && possible_name.length > 0
            @name = possible_name
            "hello #{@name}"
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

        if data[-1] != "\n"
          send_data "\n"
        end
      end
    end
  end
end

