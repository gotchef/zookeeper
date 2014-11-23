
executable_path = ::File.join(node[:zookeeper][:install_dir],
                              "zookeeper-#{node[:zookeeper][:version]}",
                              'bin',
                              'zkServer.sh')

case node[:zookeeper][:service_style]
when 'runit'
  runit_service 'zookeeper' do
    default_logger true
    options({
      exec: executable_path
    })
    action [:restart]
  end
when 'exhibitor'
  Chef::Log.info("Assuming Exhibitor will start up Zookeeper.")
else
	raise
end

