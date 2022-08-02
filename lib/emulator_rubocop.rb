# frozen_string_literal: true

require_relative "modules/version"
require_relative "modules/yaml_parser"
require_relative "modules/errors"

class EmulatorRubocop
  include Modules

  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @args = args
    @arr_of_files_path = check_file_path?(args[0]) || Dir['./app/*.rb'] + Dir['./web/*.rb']
    @founded_errors = {}
    @specific_cop = args[1]
  end

  def call
    find_warnings
    show_errors
  end

  private

  attr_reader :arr_of_files_path, :founded_errors, :specific_cop, :args

  def find_warnings
    arr_of_files_path.each do |file_path|
      file = File.open(file_path, 'r')
      file_data_array = file.readlines

      file_data_array.each_with_index do |el, idx|
        case
        when el.include?('binding.pry')
          founded_errors[:binding_pry] = message(file_path, idx, Modules::Errors::BindingError.new)
        when el.include?('.send')
          founded_errors[:send] = message(file_path, idx, Modules::Errors::SendMethodError.new)
        when el.include?('.public_send')
          founded_errors[:public_send] = message(file_path, idx, Modules::Errors::SendMethodError.new)
        end
      end
      file.close
    end
  end

  def check_file_path?(file_path)
    file_path ? [file_path] : nil
  end

  def message(file_path, index, error)
    "#{file_path}:#{index+1}: #{error}:"
  end

  def show_errors
    if specific_cop
      puts "#{founded_errors[specific_cop.to_sym]} found #{specific_cop}"
    elsif cops_from_yaml
      cops_from_yaml.each do |cop|
        puts "#{founded_errors[cop.to_sym]} found #{cop}" if founded_errors.include?(cop.to_sym)
      end
    else
      founded_errors.each { |key, value| puts "#{value} found #{key}" }
    end
  end

  def cops_from_yaml
    Modules::YamlParser.configuration
  end
end
