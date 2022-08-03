# frozen_string_literal: true
module Cops
  class CopTemplate
    def initialize(file_path, index, warning)
      @file_path = file_path
      @index = index
      @warning = warning
    end

    def call
      warning_message(@file_path, @index, @warning)
    end

    private

    def warning_message(file_path, index, warning)
      "#{file_path}:#{index + 1}: #{warning}:"
    end
  end
end
