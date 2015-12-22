module Csvlint
  module ErrorCollector
    attr_reader :errors, :warnings, :info_messages
    
    # Creates a validation error
    def build_errors(type, category = nil, row = nil, column = nil, content = nil, constraints = {})
      handle_output(Csvlint::ErrorMessage.new(type, category, row, column, content, constraints), @errors, :red)
      
    end
    # Creates a validation warning
    def build_warnings(type, category = nil, row = nil, column = nil, content = nil, constraints = {})
      handle_output(Csvlint::ErrorMessage.new(type, category, row, column, content, constraints), @warnings, :yellow)
    end
    # Creates a validation information message
    def build_info_messages(type, category = nil, row = nil, column = nil, content = nil, constraints = {})
      handle_output(Csvlint::ErrorMessage.new(type, category, row, column, content, constraints), @info_messages, :blue)
    end

    def handle_output(result, list, color)
      if $bigFile
        Csvlint::ResultOutput.print_result(result, color, $schema)
      else
        list << result
      end
    end

    def valid?
      errors.empty?
    end

    def reset
      @errors = []
      @warnings = []
      @info_messages = []
    end

    
  end
end
