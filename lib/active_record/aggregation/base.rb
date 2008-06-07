module ActiveRecord
  module Aggregation

    class Base
      # declares the attribute names for positional arguments to initialize
      class << self; attr_reader :aggregated_properties; end

      def self.aggregates(*arguments)
        self.instance_variable_set("@aggregated_properties", arguments)
        attr_reader *arguments
      end

      # initialize an instance using positional arguments, an options hash, or both.
      # when both are used, the options hash values take precedence.
      def initialize(*arguments)
        options = arguments.extract_options!
        self.class.aggregated_properties.each do |arg|
          instance_variable_set("@#{arg}", arguments.shift)
        end
        options.each do |arg, argv|
          instance_variable_set("@#{arg}", argv)
        end
      end

      # Duplicate the aggregation, overwriting any existing values 
      # with the values passed in according to the same semantics of initialize
      def dup(*arguments)
        args = {}

        self.class.aggregated_properties.each do |arg|
          args[arg] = instance_variable_get("@#{arg}")
        end
        
        arguments.each_with_index do |argv,i|
          args[self.class.aggregated_properties[i]] = argv
        end
        
        args.merge!(arguments.extract_options!)
        
        self.class.new(args)
      end

    end

  end
end