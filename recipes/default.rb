# recipes/default.rb
#

# download and install base package
include_recipe 'zookeeper::install'

# set config path and render config
include_recipe 'zookeeper::configure'

include_recipe 'zookeeper::service'
