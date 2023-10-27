# frozen_string_literal: true

module RubySheet
  class Sheet
    attr_reader :cells

    def initialize(width, height, default: nil)
      @cells = Array.new(width) { Array.new(height) { default } }
    end

    def width = @cells.size
    def height = @cells.first.size

    def get_ref(ref)
      @cells[ref.col][ref.row]
    end

    def get_span(span)
      raise NotImplementedError
    end

    def [](col, row) = @cells[col][row]

    def resize!(width: self.width, height: self.height)
      if height > self.height
        @cells.each { |col| col.fill(nil, self.height...height) }
      elsif height < self.height
        @cells.each { |col| col.slice!(height...self.height) }
      end

      if width > self.width
        @cells.fill(self.width...width) { Array.new(height) }
      elsif width < self.width
        @cells.slice!(width...self.width)
      end
    end

    def update!(*a, **b)
      pp('update', a:, b:)
    end
  end
end
