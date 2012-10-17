module Alchemist
  module Curses
    class ItemWindow
      include FFI::NCurses

      def initialize(label, size, line, column)
        @label = label
        @width = label.length + size * 2
        @win = newwin 1, @width, line, column
        @items = ""
      end

      def update(items)
        @items = items.force_encoding Encoding::UTF_8
        draw
      end

      def draw
        wclear @win
        wprintw @win, "#{@label}#{@items.pad_to_unicode_monospace}"
        wrefresh @win
      end

      def have_user_select
        wmove @win, 0, @label.length
        wrefresh @win

        while (c = getch) != KEY_RETURN
          case c
          when KEY_LEFT
            y,x = getyx @win
            new_x = [x - 2, @label.length].max
            wmove @win, 0, new_x
            wrefresh @win

          when KEY_RIGHT
            y,x = getyx @win
            new_x = [x + 2, @width - 1].min
            wmove @win, 0, new_x
            wrefresh @win

          when KEY_ESCAPE
            return nil
          end
        end

        y,x = getyx @win

        item_at x
      end

      def item_at(x)
        inv_index = (x - @label.length) / 2
        @items[inv_index]
      end
    end
  end
end

