#
# Set attributes for dependant nodes that are currently online at the time this recipe was run
#  - if a node is not online it will get missed, this is a problem

layer_name = node[:zookeeper][:aws][:layer]
instances = node[:opsworks][:layers][layer_name][:instances]

Chef::Log.debug("For #{layer_name} found #{instances} ")
hosts = []
instances.each do |name, instance| 
	hosts.push(instance[:private_ip])
end

node.normal[:zookeeper][:nodes] = hosts

if hosts.length == 0
Chef::Application.fatal!("No hosts", 42) if hosts.length == 0
end

