# Hooks to attach to the Redmine base layouts(for right sidebar).
class EstimatedTimeSidebarHook < Redmine::Hook::ViewListener

  def view_layouts_base_sidebar(context = { })
    %Q(Time: #{Time.now})
  end

end