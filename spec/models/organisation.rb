class Organisation < ActiveRecord::Base
  acts_as_configurable :some_property => {
    :default => "left",
    :options => ["left", "middle", "right"],
    :description => "Where should we put something?"}
end