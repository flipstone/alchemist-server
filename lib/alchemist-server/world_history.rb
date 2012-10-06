module Alchemist
  class WorldHistory
    def initialize(event, prior_history)
      @event = event
      @prior_history = prior_history
    end

    def to_s
      <<-str
#{@event}
#{@prior_history}
      str
    end

    def self.parse(string)
      split_into_chronological_events(string).reduce(nil) do |history, event_string|
        new Event.parse(event_string), history
      end
    end

    def self.split_into_chronological_events(string)
      string.split("\n\n").reject { |l| l =~ /^\s*$/ }.reverse
    end
  end
end

