module ActsAsConfigurable
end
current_dir = File.dirname(__FILE__)
%w( acts_methods configuration_store ).each do |to_load|
  require "#{current_dir}/acts_as_configurable/#{to_load}"
end