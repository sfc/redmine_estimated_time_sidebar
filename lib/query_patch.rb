require_dependency 'query'
 
module QueryPatch
  def self.included(base) # :nodoc:
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods) 

    base.class_eval do
      unloadable
    end
  end
  
  module ClassMethods
    
  end
  
  module InstanceMethods
    def issue_sum_estimated_hours
      Issue.sum(:estimated_hours, :include => [:status, :project], :conditions => statement)
    rescue ::ActiveRecord::StatementInvalid => e
      raise StatementInvalid.new(e.message)
    end

    def issue_sum_estimated_hours_by_group
      r = nil
      if grouped?
        begin
          # Rails will raise an (unexpected) RecordNotFound if there's only a nil group value
          r = Issue.sum(:estimated_hours, :group => group_by_statement, :include => [:status, :project], :conditions => statement)
        rescue ActiveRecord::RecordNotFound
          r = { nil => issue_count }
        end
        c = group_by_column
        if c.is_a?(QueryCustomFieldColumn)
          r = r.keys.inject({}) {|h, k| h[c.custom_field.cast_value(k)] = r[k]; h}
        end
      end
      r
    rescue ::ActiveRecord::StatementInvalid => e
      raise StatementInvalid.new(e.message)
    end
  end  
end
 
# Add module to Query
Query.send(:include, QueryPatch)