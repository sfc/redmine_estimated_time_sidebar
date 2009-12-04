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
    def issue_sum
      Issue.sum(:estimated_hours, :include => [:status, :project], :conditions => statement)
    rescue ::ActiveRecord::StatementInvalid => e
      raise StatementInvalid.new(e.message)
    end

    def issue_sum_remaining
      Issue.sum('estimated_hours * (100 - (done_ratio))/100', :include => [:status, :project], :conditions => statement)
    rescue ::ActiveRecord::StatementInvalid => e
      raise StatementInvalid.new(e.message)
    end
    
  end
end

# Add module to Query
Query.send(:include, QueryPatch)