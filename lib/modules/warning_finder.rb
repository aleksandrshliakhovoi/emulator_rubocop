# frozen_string_literal: true

require_relative 'cops/all_cops_mapper'
require_relative 'cops/cop_template'
require_relative 'errors'

module Modules
  class WarningFinder
    include Cops
    def initialize(arr_of_files_path)
      @founded_warnings = Cops::AllCopsMapper.all_cops_hash
      @arr_of_files_path = arr_of_files_path
    end

    def call
      find_warnings
      founded_warnings
    end

    private

    attr_reader :arr_of_files_path, :founded_warnings

    def find_warnings
      arr_of_files_path.each do |file_path|
        file = File.open(file_path, 'r')
        file_data_array = file.readlines

        file_data_array.each_with_index do |el, idx|
          case
          when el.include?('binding.pry')
            founded_warnings[:binding_pry] << Cops::CopTemplate.new(file_path, idx, Modules::Errors::BindingError.new).call
          when el.include?('.send')
            founded_warnings[:send] << Cops::CopTemplate.new(file_path, idx, Modules::Errors::SendMethodError.new).call
          when el.include?('.public_send')
            founded_warnings[:public_send] << Cops::CopTemplate.new(file_path, idx, Modules::Errors::SendMethodError.new).call
          end
        end
        file.close
      end
    end
  end
end
