# frozen_string_literal: true

module Errors
  class NotFoundError < StandardError
    def initialize(file_path = nil)
      message = "File not found by path '#{file_path}'"
      super(message)
    end
  end
end
