# frozen_string_literal: true

module RubySheet
  module Widgets
    class StatusBar < Gtk::Box
      type_register

      def initialize
        super()

        self.spacing = 8

        s = Gtk::Spinner.new
        append(s)

        vsep = Gtk::Separator.new(:vertical)
        append(vsep)

        l = Gtk::Label.new('meow')
        append(l)

      end
    end
  end
end
