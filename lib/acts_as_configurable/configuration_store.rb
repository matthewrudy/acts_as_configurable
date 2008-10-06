module ActsAsConfigurable
  module ConfigurationStore
    def self.included(klass)
      # klass.extend(ClassMethods)
      klass.belongs_to :configured, :polymorphic => true
    end
  end
end