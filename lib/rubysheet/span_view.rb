# frozen_string_literal: true

module RubySheet
  class SpanView
    attr_reader :sheet, :ref

    def initialize(sheet:, ref:)
      raise ArgumentError unless ref.is_a? SpanRef

      @sheet = sheet
      @ref = ref
    end

    def width = @ref.last.col - @ref.first.col + 1
    def height = @ref.last.row - @ref.first.row + 1

    def [](col, row)
      raise ArgumentError \
        unless (0...width).include?(col) && (0...height).include?(row)

      @sheet[ref.first.col + col][ref.first.row + row]
    end

    def to_a
      Array.new(width) { |i| @sheet[@ref.first.col + i][@ref.first.row, height] }
    end
  end
end
