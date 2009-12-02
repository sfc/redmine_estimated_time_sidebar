require 'redmine'

# Hooks
require_dependency 'query_patch'
require_dependency 'estimated_time_sidebar_hook'

Redmine::Plugin.register :redmine_estimated_time_sidebar do
  name 'Redmine Estimated Time Sidebar plugin'
  author 'Kevin Marsh <kmarsh@sfcgraphics.com>'
  description 'Show the total amount of estimated time on the issue list sidebar, optionally grouped'
  version '1.0'
end