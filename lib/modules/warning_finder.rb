# frozen_string_literal: true

require_relative 'cops/all_founded_cops'
require_relative 'cops/cops_mapper'
require_relative 'cops/cop_template'
require_relative 'errors/binding_error'
require_relative 'errors/send_method_error'
require_relative 'errors/not_found_error'

module Modules
  class WarningFinder
    def initialize(file_paths)
      @founded_warnings = Cops::AllFoundedCops.all_cops_hash
      @file_paths = file_paths
    end

    def call
      find_warnings
      founded_warnings
    end

    private

    attr_reader :file_paths, :founded_warnings

    def find_warnings
      file_paths.each do |file_path|
        file = File.open(file_path, 'r')
        file_data = file.readlines

        file_data.each_with_index do |element, index|
          case
          when element.include?(Cops::MAPPER[:binding_pry])
            founded_warnings[:binding_pry] << Cops::CopTemplate.new(file_path, index, Errors::BindingError.new).call
          when element.include?(Cops::MAPPER[:send])
            founded_warnings[:send] << Cops::CopTemplate.new(file_path, index, Errors::SendMethodError.new).call
          when element.include?(Cops::MAPPER[:public_send])
            founded_warnings[:public_send] << Cops::CopTemplate.new(file_path, index, Errors::SendMethodError.new).call
          end
        end
        file.close
      end
    end
  end
end
