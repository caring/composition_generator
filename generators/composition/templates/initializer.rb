require 'lib/<%= file_name %>_composer'
ActiveRecord::Base.send(:include, <%= class_name %>Composer)
