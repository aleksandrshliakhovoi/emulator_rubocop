# frozen_string_literal: true

require_relative 'yaml_parser'

module Modules
  class WarningPresenter
    def initialize(founded_warnings, specific_cop)
      @founded_warnings = founded_warnings
      @specific_cop = specific_cop
    end

    attr_reader :founded_warnings, :specific_cop

    def call
      if specific_cop
        output_warnings(founded_warnings[specific_cop.to_sym], specific_cop)
      elsif cops_from_yaml
        cops_from_yaml.each do |cop|
          output_warnings(founded_warnings[cop.to_sym], cop)
        end
      else
        founded_warnings.each { |key, element| output_warnings(element, key) }
      end
    end

    private

    def cops_from_yaml
      YamlParser.configuration
    end

    def output_warnings(warnings, cop)
      warnings.each { |warning| puts "#{warning} found #{cop}" }
    end
  end
end
