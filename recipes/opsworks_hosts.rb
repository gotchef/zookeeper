#
# Set attributes for dependant nodes that are currently online at the time this recipe was run
#  - if a node is not online it will get missed, this is a problem

instances = node[:opsworks][:layers]['zookeeper'][:instances]


Chef::Log.info("For #{instances.length} found ")
hosts = []
instances.each do |name, instance| 
	hosts.push(instance[:private_ip])
end

Chef::Log.info("For #{hosts} found ")
node.normal[:zookeeper][:nodes] = hosts


