require 'motion-require'

Motion::Require.all(Dir.glob(File.expand_path('../motion_wechat/*.rb', __FILE__)))

unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

Motion::Project::App.setup do |app|
  app.vendor_project(File.expand_path(File.join(File.dirname(__FILE__), '../vendor/wechat-sdk')), :static)
  
  app.resources_dirs << File.join(File.dirname(__FILE__), '../resources')
end