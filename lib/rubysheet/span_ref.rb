# frozen_string_literal: true

module RubySheet
  SpanRef = Data.define(:first, :last) do
    def initialize(first:, last: first)
      raise ArgumentError, 'Cell span ends before it starts' \
        if last.col < first.col || last.row < first.row

      super
    end

    def self.regex
      /
        \A
          (?<first>#{CellRef.regex})
          (?<last>#{CellRef.regex})
        \z
      /x
    end

    def self.parse(str)
      str.upcase!

      case str.match(regex)
      in first:, last:
        new(CellRef.parse(first), CellRef.parse(last))
      else
        raise ArgumentError, 'Invalid cell span'
      end
    end
  end
end
