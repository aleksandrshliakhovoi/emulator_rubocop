# frozen_string_literal: true

require_relative 'modules/version'
require_relative 'modules/warning_presenter'
require_relative 'modules/warning_finder'

class EmulatorRubocop
  include Modules

  def self.call(args)
    new(args).call
  end

  DEFAULT_PATH = '{app, web}/**/*.rb'

  def initialize(args)
    @file_paths = check_file_path?(args[0]) || Dir.glob(DEFAULT_PATH)
    @specific_cop = args[1]
    @founded_warnings = Modules::WarningFinder.new(file_paths).call
  end

  def call
    Modules::WarningPresenter.new(founded_warnings, specific_cop).call
  end

  private

  attr_reader :file_paths, :founded_warnings, :specific_cop

  def check_file_path?(file_path)
    file_path ? [file_path] : nil
  end
end
