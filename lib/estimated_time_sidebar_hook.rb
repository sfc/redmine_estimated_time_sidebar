# Hooks to attach to the Redmine base layouts (for right sidebar).
class EstimatedTimeSidebarHook < Redmine::Hook::ViewListener

  def view_layouts_base_sidebar(context = { })
    query = context[:controller].instance_variable_get("@query") rescue nil

    if query
      total_estimated_time = query.issue_sum
      total_estimated_time_remaining = query.issue_sum_remaining
      
      %Q[<h3>Total Estimated time</h3>
        #{html_hours("%.2f" % total_estimated_time)} (#{html_hours("%.2f" % total_estimated_time_remaining)} remaining)<br />
        #{progress_bar((total_estimated_time_remaining.to_f/total_estimated_time.to_f)*100.0)}
      ]
    else
      ''
    end
  end

end