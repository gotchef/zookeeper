# resources/node.rb
#

actions(:create, :delete, :create_if_missing)
default_action(:create)

attribute :path,        kind_of: String, name_attribute: true
attribute :connect_str, kind_of: String, required: true
attribute :data,        kind_of: String
