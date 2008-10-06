module ActsAsConfigurable
  class ConfigurableProperty
    attr_reader :name, :description, :default, :type
  
    def initialize(attribs={})
      @name = attribs[:name]
      @description = attribs[:description]
      @default = attribs[:default]
      @type = :select
    end
  end
end