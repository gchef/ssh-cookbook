actions :setup

attribute :username,  :kind_of => String, :name_attribute => true
attribute :ssh_keys,  :kind_of => Array, :default => []
attribute :home,      :kind_of => String

def initialize(*args)
  super
  @action = :setup
end
