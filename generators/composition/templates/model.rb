class <%= class_name %> < ActiveRecord::Aggregation::Base

  aggregates :<%= aggregated_fields.map.join(', :') %>

end
