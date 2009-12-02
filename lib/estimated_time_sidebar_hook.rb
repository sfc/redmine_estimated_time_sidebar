# Hooks to attach to the Redmine base layouts (for right sidebar).
class EstimatedTimeSidebarHook < Redmine::Hook::ViewListener

  def view_layouts_base_sidebar(context = { })
    output = ''
    output << '<h3>Total Estimated time</h3>'
    
    query = context[:controller].instance_variable_get("@query") rescue nil
    
    if query
      if query.grouped?
        total_estimated_time_by_group = query.issue_sum_estimated_hours_by_group
        
        total_estimated_time_by_group.each do |group, estimated_hours|
          name = group.name rescue group.id
          output << %Q(#{name}: #{'%.2f' % estimated_hours}<br />)
        end        
      else
        total_estimated_time = query.issue_sum_estimated_hours
        output << %Q(#{html_hours("%.2f" % total_estimated_time)})        
      end
    else
      %Q(<pre>No query</pre>)      
    end
    
    output
  end
end