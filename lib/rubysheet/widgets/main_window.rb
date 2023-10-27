# frozen_string_literal: true

module RubySheet
  module Widgets
    class MainWindow < Adwaita::Window
      type_register

      def initialize(app)
        super(application: app)

        self.title = 'RubySheet'

        box = Gtk::Box.new(:vertical, 4)
        self.content = box

        hb = Adwaita::HeaderBar.new
        box.append(hb)

        content = WindowContent.new
        box.append(content)
      end
    end
  end
end
