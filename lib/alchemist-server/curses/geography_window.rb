module Alchemist
  module Curses
    class GeographyWindow
      include FFI::NCurses

      def initialize(line, col, avatar_color_num = nil)
        @win = newwin 20, 43, line, col
        @avatar_color_num = avatar_color_num
        @avatars = {}
        @loc_x, @loc_y = nil
        @data = ''
      end

      def draw
        wclear @win
        wmove @win, 0, 0
        draw_colored_data @data.force_encoding Encoding::UTF_8
        move_to_avatar_position
      end

      def draw_colored_data(data)
        data.each_line.with_index do |line, y|
          line.each_char.with_index do |c, x|
            if @avatar_color_num && avatar_at?(x, y)
              wattr_set @win, A_NORMAL, @avatar_color_num, nil
            else
              wattr_set @win, A_NORMAL, 0, nil
            end

            wprintw @win, c.pad_to_unicode_monospace
          end
        end
      end

      def avatar_at?(x,y)
        @avatars.values.include? [x + (@loc_x - 10),
                                  y + (@loc_y - 10)]
      end

      def update(location, data)
        @loc_x, @loc_y = location
        @data = data
        draw
      end

      def update_avatar(name, x, y)
        @avatars[name] = [x,y]
        draw
      end

      def update_avatars(avatars)
        @avatars = avatars.dup
        draw
      end

      def move_to_avatar_position
        wmove @win, 10, 20
        wrefresh @win
      end
    end
  end
end

