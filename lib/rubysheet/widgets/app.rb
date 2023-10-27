# frozen_string_literal: true

module RubySheet
  module Widgets
    class App < Adwaita::Application
      private def load_css
        css_provider = Gtk::CssProvider.new
        css_provider.load(path: RubySheet.asset_path('style.css'))

        Gtk::StyleContext.add_provider_for_display(
          Gdk::Display.default,
          css_provider
        )
      end

      def initialize
        super('dev.ap5.rubysheet', :flags_none)

        load_css

        signal_connect :activate do |app|
          win = MainWindow.new(app)
          win.present
        end
      end
    end
  end
end
