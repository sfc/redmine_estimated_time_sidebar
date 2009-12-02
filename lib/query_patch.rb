require_dependency 'query'
 
module QueryPatch
  def self.included(base) # :nodoc:
    base.extend(ClassMethods)
 
    base.send(:include, InstanceMethods)
 
    # Same as typing in the class 
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
    end
 
  end
  
  module ClassMethods
    
  end
  
  module InstanceMethods
    # Wraps the association to get the Deliverable subject.  Needed for the 
    # Query and filtering
    def issue_sum
      Issue.sum(:estimated_hours, :include => [:status, :project], :conditions => statement)
    rescue ::ActiveRecord::StatementInvalid => e
      raise StatementInvalid.new(e.message)
    end
  end
end
 
# Add module to Query
Query.send(:include, QueryPatch)