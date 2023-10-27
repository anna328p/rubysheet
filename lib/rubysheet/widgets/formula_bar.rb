# frozen_string_literal: true

module RubySheet
  module Widgets
    class FormulaBar < Gtk::Box
      type_register

      def initialize
        super()

        f = Gtk::TextView.new
        f.monospace = true
        f.hexpand = true

        f.buffer.text = 'meow'

        append(f)
      end
    end
  end
end
