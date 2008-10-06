module ActsAsConfigurable
  module ActsMethods
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def acts_as_configurable(properties)
        has_many :configured_properties, :as => :configured
        self.class_inheritable_accessor :configurable_properties
        self.configurable_properties = properties
        after_save :save_configured_properties
        
        include ActsAsConfigurable::ActsMethods::InstanceMethods
        
        properties.each_key do |property|
          define_method(property) do
            config_for(property)
          end
          
          define_method("#{property}=") do |value|
            set_config_for(property, value)
          end
        end
      end
    end
    
    module InstanceMethods
      def config_for(property)
        if record = get_configuration_record(property) 
          return record.value
        else
          return self.configurable_properties[property][:default]
        end
      end
      
      def get_configuration_record(property)
        self.configured_properties.detect{|object| object.property == property.to_s}
      end
      
      def set_config_for(property, value)
        if existing = self.get_configuration_record(property)
          existing.value = value
        else
          self.configured_properties.build(:property => property.to_s, :value => value)
        end
      end
      
      def save_configured_properties
        self.configured_properties.map(&:save)
      end
    end
  end
end