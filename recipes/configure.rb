# recipes/config_files.rb
#

include_recipe 'runit'

include_recipe 'zookeeper::opsworks_hosts'

zookeeper_hosts = node[:zookeeper][:nodes] 

runit_service 'zookeeper' do
    action :nothing
end


# use explicit value if set, otherwise make the leader a server iff there are
# four or more zookeepers kicking around
leader_is_also_server = node[:zookeeper][:leader_is_also_server]

hostname = node['hostname']
# zookeeper-01, get the 01 part
hostNumber = hostname.split('-')[1].strip.to_i
node.default[:zookeeper][:myid] = hostNumber

template_variables = {
  :zookeeper         	=> node[:zookeeper],
  :zookeeper_hosts   	=> zookeeper_hosts,
  :leader_is_also_server => leader_is_also_server,
}

directory "#{node[:zookeeper][:conf_link_dir]}" do
  owner "root"
  group "root"
  mode '00755'
  recursive true
  action :create
end

logConfig = "log4j.properties"
logPath = "#{node[:zookeeper][:conf_dir]}/#{logConfig}"

template logPath do
   variables   template_variables
   owner       "root"
   mode        "0644"
   source      "#{logConfig}.erb"
   notifies :restart, "runit_service[zookeeper]"
end

config = "zoo.cfg"
configPath =  "#{node[:zookeeper][:conf_dir]}/#{config}" 
template configPath do
   variables   template_variables
   owner       "root"
   mode        "0644"
   source      "#{config}.erb"
   notifies :restart, "runit_service[zookeeper]"
end

template "#{node[:zookeeper][:data_dir]}/myid" do
  owner         "zookeeper"
  mode          "0644"
  variables     template_variables
  source        "myid.erb"
end

#create sym link
link  "#{node[:zookeeper][:conf_link_dir]}/#{config}" do
	to configPath	
end

link  "#{node[:zookeeper][:conf_link_dir]}/#{logConfig}" do
	to logPath	
end

include_recipe 'zookeeper::service'
