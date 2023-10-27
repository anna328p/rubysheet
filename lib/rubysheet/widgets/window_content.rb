# frozen_string_literal: true

module RubySheet
  module Widgets
    class WindowContent < Gtk::Box
      type_register

      def initialize
        super({ orientation: :vertical, spacing: 4 })

        fb = FormulaBar.new
        append(fb)

        append Gtk::Separator.new(:horizontal)

        # TODO
        sheet = Sheet.new(5, 5, default: 'meow')
        sv = DocumentView.new(sheet:)
        append(sv)

        append Gtk::Separator.new(:horizontal)

        sb = StatusBar.new
        append(sb)
      end
    end
  end
end
