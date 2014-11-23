# providers/default.rb
#

def initialize(new_resource, run_context)
  super
  @dependency_gems = zk_dependency_gems
end

# Install Zookeeper
action :install do
  @dependency_gems.each do |gem|
    gem.run_action(:install)
  end

end

# Uninstall Zookeeper
action :uninstall do
  Chef::Log.error("Unimplemented method :uninstall for resource `zookeeper'")
end

private

def zk_dependency_gems
  return ['zookeeper', 'json'].collect {|gem| Chef::Resource::ChefGem.new(gem, @run_context)}
end
