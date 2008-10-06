require 'rubygems'
require 'spec'
require 'active_record'

current_dir = File.dirname(__FILE__)
require "#{current_dir}/../lib/acts_as_configurable"
require "#{current_dir}/../init"
require "#{current_dir}/models/configured_property"
require "#{current_dir}/models/organisation"
 
config = YAML::load(IO.read(current_dir + '/database.yml'))
ActiveRecord::Base.logger = Logger.new(current_dir + "/debug.log")
ActiveRecord::Base.establish_connection(config['configurable_test'])
load(current_dir + "/schema.rb")