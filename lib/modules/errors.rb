# frozen_string_literal: true

module Modules
  module Errors
    class RubocopBaseError < StandardError
      self
    end

    class BindingError < RubocopBaseError; end

    class SendMethodError < RubocopBaseError; end

    class NotFoundError < StandardError
      def initialize(file_path = nil)
        message = "File not found by path '#{file_path}'"
        super(message)
      end
    end
  end
end
