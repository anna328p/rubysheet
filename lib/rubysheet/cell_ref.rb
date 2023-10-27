# frozen_string_literal: true

module RubySheet
  CellRef = Data.define(:col, :row, :col_pinned, :row_pinned) do
    def initialize(col:, row:, col_pinned: false, row_pinned: false)
      super
    end

    def self.alpha_to_index(str)
      raise ArgumentError unless str.match?(/[A-Z]+/)

      values = str.chars.map { _1.ord - 'A'.ord + 1 }
      values.reduce(0) { |acc, i| acc * 26 + i }
    end

    def self.index_to_alpha(num)
      from = ('0'..'9').to_a + ('a'..'p').to_a
      to = ('A'..'Z').to_a

      num.to_s(26).tr(from.join, to.join)
    end

    def self.regex
      /
        (?<cpin>\$)?(?<col>[A-Z]+)
        (?<rpin>\$)?(?<row>\d+)
      /x
    end

    def self.parse(str)
      str.upcase!

      case str.match(/\A#{regex}\z/)
      in col:, row:, cpin:, rpin:
        new(col: alpha_to_index(col), row: row.to_i,
            col_pinned: cpin ? true : false,
            row_pinned: rpin ? true : false)
      else
        raise ArgumentError, 'Invalid cell reference'
      end
    end
  end
end
