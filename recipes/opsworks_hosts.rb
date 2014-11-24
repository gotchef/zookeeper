#
# Set attributes for dependant nodes that are currently online at the time this recipe was run
#  - if a node is not online it will get missed, this is a problem

zookeeper_layer_name = node[:zookeeper][:aws][:layer] 
instances = node[:opsworks][:layers][zookeeper_layer_name][:instances]

#debug code
layers = node[:opsworks][:layers]
layers.each do |k, v| 
	Chef::Log.info("Layer #{k} found ")
	inst = v[:instances]
	inst.each do |a,b|
		Chef::Log.info("instance #{a} found ")
	end
end

Chef::Log.info("For #{instances.length} found ")
hosts = []
instances.each do |name, instance| 
	hosts.push(instance[:private_ip])
end

Chef::Log.info("For #{hosts} found ")
node.normal[:zookeeper][:nodes] = hosts


