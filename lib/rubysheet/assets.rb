# frozen_string_literal: true

module RubySheet
  def self.asset_path(*components)
    File.join(__dir__, '..', '..', 'share', *components)
  end
end
