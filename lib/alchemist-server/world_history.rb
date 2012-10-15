module Alchemist
  class WorldHistory
    attr_reader :world

    def initialize(event, prior_history)
      @event = event
      @prior_history = prior_history

      @world =
        if @prior_history.nil?
          World.genesis
        else
          outcome = @event.happen @prior_history
          outcome.try(:new_world) || @prior_history.world
        end
    end

    def to_s
      <<-str.strip
#{@prior_history}

#{@event}
      str
    end

    def self.parse(string)
      split_into_chronological_events(string).reduce(nil) do |history, event_string|
        new Event.parse(event_string), history
      end
    end

    def self.split_into_chronological_events(string)
      string.split("\n\n").reject { |l| l =~ /^\s*$/ }
    end

    def self.genesis
      new Event.genesis, nil
    end
  end
end

