module Alchemist
  module UnicodeMonospace
    module StringExtensions
      def pad_to_unicode_monospace
        split('').flat_map do |c|
          next c if c == "\n"

          case UnicodeMonospace.east_asian_width(c)
          when /^F|W$/ then c
          else [c, ' ']
          end
        end.join('')
      end
    end

    def self.east_asian_width(c)
      east_asian_widths[c.ord]
    end

    def self.east_asian_widths
      @east_asian_widths ||= build_east_asian_widths
    end

    DATA_FILE = File.join(File.dirname(__FILE__), 'EastAsianWidth.txt')

    def self.build_east_asian_widths
      widths = {}
      File.open(DATA_FILE) do |io|
        io.each_line do |line|
          next if line =~ /^#/
          code, width, _ = line.split(/;|#/)
          widths[code.to_i(16)] = width && width.strip
        end
      end

      widths
    end
  end
end

String.class_eval do
  include Alchemist::UnicodeMonospace::StringExtensions
end
__END__
