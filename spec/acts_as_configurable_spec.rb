require File.dirname(__FILE__) + '/spec_helper'

describe ActsAsConfigurable do
  before(:each) do
    ConfiguredProperty.delete_all
  end
  
  describe "configurable_properties" do
    before(:each) do
      # it "should be the same as the hash provided by :acts_as_configurable" do
      @properties = {:some_property => {
        :default => "left",
        :options => ["left", "middle", "right"],
        :description => "Where should we put something?"}}
    end
    
    it "should be available as an instance method" do
      Organisation.new.configurable_properties.should == @properties
    end
    
    it "should be available as a class method" do
      Organisation.configurable_properties.should == @properties
    end
  end
  
  describe "property getters" do
    before(:each) do
      @it = Organisation.new(:name => "something")
      @it.save
    end
    
    it "should defer to the default if no record exists" do
      @it.configured_properties.should == []
      @it.some_property.should == "left"
      
      ConfiguredProperty.count.should == 0
      @it.configurable_properties[:some_property][:default] = "something else"
      @it.some_property.should == "something else"
      
      @it.configurable_properties[:some_property][:default] = "left" # put it back at the end
    end
      
  end
  
  describe "property setters" do
    before(:each) do
      @it = Organisation.new(:name => "something")
      @it.save
    end
    
    it "should set a writer for each property" do
      @it.should respond_to("some_property=")
    end
    
    it "should write the attribute without saving" do
      ConfiguredProperty.count.should == 0
      @it.some_property.should == "left"
      @it.some_property = "right"
      
      @it.reload
      @it.some_property.should == "left"
    end
    
    it "should save the attribute on saving the record" do
      ConfiguredProperty.count.should == 0
      @it.some_property.should == "left"
      @it.some_property = "right"
      @it.save
      
      ConfiguredProperty.count.should == 1
      
      @it.reload
      @it.some_property.should == "right"
    end
    
    it "should save a setting if a setting already exists" do
      @it.some_property = "right"
      @it.save
      ConfiguredProperty.count.should == 1

      @it.reload
      @it.some_property.should == "right"
      @it.some_property = "middle"
      @it.some_property.should == "middle"
      @it.save.should == true
      ConfiguredProperty.count.should == 1
      
      @it.reload
      @it.some_property.should == "middle"
    end
  end
end