module Csvlint
  class ResultOutput
    class << self
      def print_result(result, color, schema)
        
        currentField = ""
        if result.column && schema && schema.class == Csvlint::Schema
          currentField = schema.fields[result.column-1]
          isRowData = true
        end

        location = ""
        location += "#{result.row.to_s}" if result.row
        #location += "#{result.row ? "," : ""}(#{currentField.name})" if result.column
        if result.row || result.column
          location = "#{result.row ? "Row" : "Column"}: #{location}"
        end
        
        # Error Number
        $index += 1
        output_string = "#{$index}"
        output_string += "\t"
        
        # Error Column Name
        if isRowData && currentField
          output_string += "(#{currentField.name})"
        end
        output_string += "\t"

        # Error location
        output_string += "#{location}" unless location.empty?
        output_string += "\t"

        # Error type
        output_string += "(#{result.type})"
        output_string += "\t"
        
        # Error Desc
        if result.type.to_s == 'pattern'
          output_string += " should match: #{currentField.constraints["pattern"]}"
        end
        output_string += "\t"

        # Actual data
        output_string += "#{result.content}" if result.content

        if $stdout.tty?
          puts output_string.colorize(color)
        else
          puts output_string
        end
      end
      
      private
    end
  end
end
