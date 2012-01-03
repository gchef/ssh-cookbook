actions :add, :add_multiline, :remove

attribute :match,      :kind_of => String,  :name_attribute => true
attribute :string,     :kind_of => String

def initialize(*args)
  super
  @action = :add
end
