module Alchemist
  module Curses
    class MessagesWindow
      include FFI::NCurses

      def initialize(height, width, line, col)
        @height = height
        @width = width

        @offset = 0
        @messages = []

        @win = newwin height, width, line, col
      end

      def draw
        wmove @win, 0, 0
        wclear @win
        wprintw @win, messages_to_show.join("\n")
        wrefresh @win
      end

      def messages_to_show
        @messages[@offset,@height] || []
      end

      def update(messages)
        @messages = messages
        draw
      end

      def scroll_up
        @offset = [@offset-1, 0].max
        draw
      end

      def scroll_down
        @offset = [@offset+1, @messages.length - height].min
        draw
      end
    end
  end
end
