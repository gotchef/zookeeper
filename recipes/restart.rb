
case node[:zookeeper][:service_style]
when 'runit'
  runit_service 'zookeeper' do
    action [:restart]
  end
when 'exhibitor'
  Chef::Log.info("Assuming Exhibitor will start up Zookeeper.")
else
	raise
end

