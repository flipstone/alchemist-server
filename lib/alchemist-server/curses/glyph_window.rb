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
        GlyphWindow.chars[range_start..range_end] || []
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
      end

      def self.chars
        @chars ||=
          [
            *(0x0021..0x0024).to_a,
            *(0x0026..0x007e).to_a,
            *(0x0100..0x0220).to_a,
            *(0x0222..0x0233).to_a,
            *(0x0250..0x02ad).to_a,
            *(0x0374..0x0375).to_a,
            *(0x037e..0x037e).to_a,
            *(0x0384..0x038a).to_a,
            *(0x038c..0x038c).to_a,
            *(0x038e..0x03a1).to_a,
            *(0x03a3..0x03ce).to_a,
            *(0x03d0..0x03f6).to_a,
            *(0x0400..0x0482).to_a,
            *(0x0488..0x04ac).to_a,
            *(0x04af..0x04ce).to_a,
            *(0x04d0..0x04f5).to_a,
            *(0x04f8..0x04f9).to_a,
            *(0x0500..0x050f).to_a,
            *(0x20a0..0x20b1).to_a,
            *(0x2100..0x213a).to_a,
            *(0x213d..0x214b).to_a,
            *(0x2153..0x2183).to_a,
            *(0x2190..0x21ff).to_a,
            *(0x2200..0x22ff).to_a,
            *(0x2300..0x23ce).to_a,
            *(0x2460..0x24fe).to_a,
            *(0x2500..0x257f).to_a,
            *(0x2580..0x259f).to_a,
            *(0x2600..0x2613).to_a,
            *(0x2616..0x2617).to_a,
            *(0x2619..0x267d).to_a,
            *(0x2680..0x2689).to_a,
            *(0x2701..0x2704).to_a,
            *(0x2706..0x2709).to_a,
            *(0x270c..0x2727).to_a,
            *(0x2729..0x274b).to_a,
            *(0x274d..0x274d).to_a,
            *(0x274f..0x2752).to_a,
            *(0x2756..0x2756).to_a,
            *(0x2758..0x275e).to_a,
            *(0x2761..0x2794).to_a,
            *(0x2798..0x27af).to_a,
            *(0x27b1..0x27bd).to_a,
            *(0x27f0..0x27ff).to_a,
            *(0x2800..0x28ff).to_a,
            *(0x2900..0x297f).to_a,
            *(0x2980..0x29ff).to_a,
            *(0x2a00..0x2aff).to_a,
            *(0x2e80..0x2e99).to_a,
            *(0x2e9b..0x2ef3).to_a,
            *(0x2f00..0x2fd5).to_a,
            *(0x2ff0..0x2ffb).to_a,
            *(0x3001..0x3020).to_a,
            *(0x3030..0x303f).to_a,
            *(0x3041..0x3054).to_a,
            *(0x305b..0x3096).to_a,
            *(0x309d..0x30ff).to_a,
            *(0x3105..0x312c).to_a,
            *(0x3131..0x318e).to_a,
            *(0x3190..0x319f).to_a,
            *(0x31a0..0x31b7).to_a,
            *(0x3200..0x321c).to_a,
            *(0x3220..0x3244).to_a,
            *(0x3251..0x327b).to_a,
            *(0x327f..0x32cb).to_a,
            *(0x32d0..0x32fe).to_a,
            *(0x3300..0x3377).to_a,
            *(0x337b..0x33dd).to_a,
            *(0x33e0..0x33fe).to_a,
            *(0xa000..0xa48c).to_a,
            *(0x4e00..0x9fff).to_a,
          ].map {|i| [i].pack("U*") }
      end
    end
  end
end

