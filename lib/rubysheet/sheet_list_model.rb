# frozen_string_literal: true

module RubySheet
  class TestModel < GLib::Object
    include Gio::ListModel
    type_register
  end

  class SheetListModel < GLib::Object
    include Gio::ListModel

    type_register

    def initialize(sheet)
      super()

      @sheet = sheet
    end

    def virtual_do_get_item(index)
      index.between?(0, @sheet.height - 1) ? index : nil
    end

    def virtual_do_get_item_type
      GLib::Type::UINT
    end

    def virtual_do_get_n_items
      @sheet.height
    end
  end
end
