class CompositionGenerator < Rails::Generator::NamedBase
  alias_method  :aggregated_fields, :args
  
  def initialize(runtime_args, runtime_options = {})
    runtime_args << runtime_args[0] if runtime_args.size == 1
    super
  end
  
  def meta_method
    "has_#{file_name}"
  end

  def manifest
    record do |m|
      m.directory File.join('app/models', class_path)
      m.directory File.join('lib', class_path)
      m.directory 'config/initializers'
      
      m.template 'model.rb',      File.join('app/models', class_path, "#{file_name}.rb")
      m.template 'composer.rb',      File.join('lib', class_path, "#{file_name}_composer.rb")
      m.template 'initializer.rb',      File.join('config/initializers', "init_#{file_name}_composer.rb")
      
      # m.migration_template 'migration.rb', 'db/migrate', :assigns => {
      #   :migration_name => "add_web_page_meta_data_table".camelcase
      # }, :migration_file_name => "add_web_page_meta_data_table"
      
    end
  end
end