
case node[:zookeeper][:service_style]
when 'runit'
  runit_service 'zookeeper' do
    action [:stop]
  end

  sleep 5

  runit_service 'zookeeper' do
    action [:start]
  end
when 'exhibitor'
  Chef::Log.info("Assuming Exhibitor will start up Zookeeper.")
else
	raise
end

