actions :add, :remove

# Name of the nrpe check, used for the filename and the command name
attribute :command_name, :kind_of => String, :name_attribute => true

attribute :warning_condition, :kind_of => String, :default => nil
attribute :critical_condition, :kind_of => String, :default => nil
attribute :command, :kind_of => String
attribute :parameters, :kind_of => String, :default => nil

def initialize(*args)
  super
  @action = :add
end

