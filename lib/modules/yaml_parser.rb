# frozen_string_literal: true
require 'yaml'

class YamlParser
  class << self
    def configuration
      cops_name_array
    rescue Errno::ENOENT
      nil
    end

    private

    def raw_cops
      YAML.safe_load(File.read('.rubocop_emulator.yml'))['all_cops']
    end

    def cops_name_array
      raw_cops.find_all { |_, value| value == 'enable' }
              .flatten
              .delete_if { |el| el == 'enable' }
    end
  end
end
