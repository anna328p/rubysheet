# frozen_string_literal: true

module RubySheet
  module Widgets
    class SheetGrid < Gtk::ColumnView
      type_register

      attr_reader :sheet

      def initialize(sheet:)
        model = TestModel.new
        pp model.get_item(1)

        super({ 'model' => model })

        @sheet = sheet

        draw
      end

      def draw
        @sheet.cells.each_with_index do |col, x|
          factory = Gtk::SignalListItemFactory.new

          empty_buf = Gtk::TextBuffer.new

          factory.signal_connect :setup do |item|
            field = Gtk::TextView.new_with_buffer(empty_buf)

            field.monospace = true
            field.accepts_tab = false

            field.height_request = 32
            field.width_request = 120

            item.set_child(field)
          end

          factory.signal_connect :bind do |item|
            field = item.get_child
            
            buf = Gtk::TextBuffer.new
            buf.text = col[item.position].to_s

            buf.signal_connect :end_user_action do |b|
              @sheet.update!(x, y, b.text)
              draw
            end

            field.buffer = buf
          end

          gcol = Gtk::ColumnViewColumn.new(CellRef.index_to_alpha(x), factory)
          append_column(gcol)
        end
      end
    end
  end
end
