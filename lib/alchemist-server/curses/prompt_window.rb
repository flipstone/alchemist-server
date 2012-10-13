module Alchemist
  module Curses
    class PromptWindow
      include FFI::NCurses

      def initialize(line, col, width)
        @win = newwin 1, width, line, col
      end

      def ask(label)
        wclear @win
        wmove @win, 0, 0
        wprintw @win, label
        wprintw @win, ': '
        wrefresh @win

        answer = ''

        while (c = wgetch @win) != "\n".ord
          if c > 0
            answer << c
            wprintw @win, (''<<c)
          end

          wrefresh @win
        end

        wclear @win

        answer.strip
      end
    end
  end
end

