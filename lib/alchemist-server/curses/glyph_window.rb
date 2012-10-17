module Alchemist
  module Curses
    class GlyphWindow
      include FFI::NCurses

      ROWS = 21
      COLS = 48

      def initialize(line,col)
        @width = (COLS + 2)*2
        @win = newwin ROWS, @width, line, col
        @starting_char = 0
        @cursor_offset = 0
      end

      def draw
        wmove @win, 0, 0
        wclear @win
        wprintw @win, rows.pad_to_unicode_monospace
        reset_cursor
      end

      def reset_cursor
        y,x = @cursor_offset.divmod COLS
        wmove @win, y, x*2
        wrefresh @win
      end

      def characters
        Glyphs.strings[range_start..range_end] || []
      end

      def rows
        characters
        .each_slice(COLS)
        .map { |slice| slice.join('') }
        .join("\n")
        .force_encoding(Encoding::UTF_8)
      end

      def range_start
        @starting_char
      end

      def range_end
        @starting_char + ROWS*COLS
      end

      def have_user_select
        draw
        wmove @win, 0, 0
        wrefresh @win

        while (c = getch) != KEY_RETURN
          y,x = getyx @win

          case c
          when KEY_ESCAPE
            return nil
          when KEY_LEFT
            @cursor_offset = [@cursor_offset - 1, 0].max
            reset_cursor
          when KEY_RIGHT
            @cursor_offset = [@cursor_offset + 1, (ROWS*COLS)].min
            reset_cursor
          when KEY_UP
            @cursor_offset = [@cursor_offset - COLS, 0].max
            reset_cursor
          when KEY_DOWN
            @cursor_offset = [@cursor_offset + COLS, (ROWS*COLS)].min
            reset_cursor
          when '0'.ord
            @starting_char += ROWS*COLS
            draw
          when '9'.ord
            @starting_char = [@starting_char-ROWS*COLS,0].max
            draw
          end
        end

        characters[@cursor_offset]
      ensure
        wclear @win
        wrefresh @win
      end
    end
  end
end

