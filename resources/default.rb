# resources/default.rb
#

actions(:install, :uninstall)
default_action(:install)

attribute :version,     kind_of: String, name_attribute: true
attribute :mirror,      kind_of: String, required: true
attribute :user,        kind_of: String, default: 'zookeeper'
attribute :install_dir, kind_of: String, default: '/opt/zookeeper'
attribute :checksum,    kind_of: String
