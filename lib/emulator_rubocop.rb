# frozen_string_literal: true

require_relative 'modules/version'
require_relative 'modules/warning_shower'
require_relative 'modules/warning_finder'

class EmulatorRubocop
  include Modules

  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @arr_of_files_path = check_file_path?(args[0]) || Dir['./app/*.rb'] + Dir['./web/*.rb']
    @specific_cop = args[1]
    @founded_warnings = Modules::WarningFinder.new(arr_of_files_path).call
  end

  def call
    Modules::WarningShower.new(founded_warnings, specific_cop).call
  end

  private

  attr_reader :arr_of_files_path, :founded_warnings, :specific_cop

  def check_file_path?(file_path)
    file_path ? [file_path] : nil
  end
end
