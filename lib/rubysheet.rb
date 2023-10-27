# frozen_string_literal: true

require 'bundler/setup'
Bundler.require(:default)

def require_each(*args)
  *dirs, names = args
  raise ArgumentError unless dirs.all? { _1.is_a? String }
  raise ArgumentError unless names.is_a?(Array)

  names.each do |name|
    raise ArgumentError unless name.is_a?(String)

    require File.join(*dirs, name)
  end
end

require_each __dir__, 'rubysheet', %w[
  version
  assets
  cell_ref
  span_ref
  sheet
  span_view
  sheet_list_model
  widgets
]
