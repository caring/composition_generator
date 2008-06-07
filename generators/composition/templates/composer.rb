module <%= class_name %>Composer
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    
    def <%= meta_method %>(options = {})
      mapping = options[:mapping] || <%= class_name %>.aggregated_properties.map{|p| [p,p]}
      name = options[:name] || :<%= file_name %>
      class_eval do
        composed_of name, :class_name => '<%= class_name %>', :mapping => mapping
      end
    end
    
  end

end
