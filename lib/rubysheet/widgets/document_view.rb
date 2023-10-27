# frozen_string_literal: true

module RubySheet
  module Widgets
    class DocumentView < Gtk::Grid
      type_register

      attr_reader :inner, :sheet

      def redraw
        @cell_grid = SheetGrid.new(sheet: @sheet)
        @window.set_child(@cell_grid)

        add_scrollbars
      end

      def add_scrollbars
        # TODO
      end

      def add_spin_buttons
        add_sbx
        add_sby
      end

      def add_sbx
        box = Gtk::Box.new(:vertical)

        @sbx = Gtk::SpinButton.new(1, 2**16, 1)
        @sbx.orientation = :vertical
        @sbx.value = @sheet.width

        @sbx.signal_connect :value_changed do |sb|
          @sheet.resize!(width: sb.value)
          redraw
        end

        box.append(@sbx)

        attach(box, 2, 0, 1, 1)
      end

      def add_sby
        box = Gtk::Box.new(:horizontal)

        @sby = Gtk::SpinButton.new(1, 2**16, 1)
        @sby.value = @sheet.height

        @sby.signal_connect :value_changed do |sb|
          @sheet.resize!(height: sb.value)
          redraw
        end

        box.append(@sby)

        attach(box, 0, 2, 1, 1)
      end

      def initialize(sheet:)
        super()

        @sheet = sheet
        @window = Gtk::ScrolledWindow.new
        @window.hexpand = true
        @window.vexpand = true

        attach(@window, 0, 0, 1, 1)

        add_spin_buttons
        redraw
      end
    end
  end
end
