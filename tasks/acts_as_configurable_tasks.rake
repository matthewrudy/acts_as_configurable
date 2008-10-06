namespace :acts_as_configurable do
  desc "Generates your ConfiguredProperty model, for storing configured properties"
  task :setup => :environment do
    require 'rails_generator'
    require 'rails_generator/scripts/generate'
    Rails::Generator::Scripts::Generate.new.run(["acts_as_configurable", "ConfiguredProperty"])
  end
end