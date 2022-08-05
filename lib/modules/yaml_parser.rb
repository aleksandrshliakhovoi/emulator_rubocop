# frozen_string_literal: true

require 'yaml'

class YamlParser
  ENABLE = 'enable'
  CONFIG_FILE = '.rubocop_emulator.yml'

  class << self
    def configuration
      cops_names
    rescue Errno::ENOENT
      nil
    end

    private

    def raw_cops
      YAML.safe_load(File.read(CONFIG_FILE))['all_cops']
    end

    def cops_names
      raw_cops.find_all { |_, value| value == ENABLE }
              .flatten
              .delete_if { |element| element == ENABLE }
    end
  end
end
