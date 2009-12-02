require 'redmine'

Redmine::Plugin.register :redmine_estimated_hours_sidebar do
  name 'Redmine Estimated Hours Sidebar plugin'
  author 'Kevin Marsh <kmarsh@sfcgraphics.com>'
  description 'Show the total amount of estimated hours on the issue list sidebar, optionally grouped'
  version '0.0.1'
end
