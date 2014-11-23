# recipes/install.rb
#

node.override['build-essential']['compile_time'] = true

#dependency
include_recipe 'build-essential'
include_recipe 'java'
include_recipe 'runit'

# == Users

user_name =  node[:zookeeper][:user]
group_name = user_name

# setup group
group group_name do
end

# setup user
user user_name do
  comment "Zookeeper Daemon"
  gid group_name
  shell "/bin/noshell"
  supports :manage_home => false
end

# == Directories 

directory "#{node[:zookeeper][:install_dir]}" do
  owner "root"
  group "root"
  mode '00755'
  recursive true
  action :create
end

directory "#{node[:zookeeper][:conf_dir]}" do
  owner "root"
  group "root"
  mode '00755'
  recursive true
  action :create
end


directory "#{node[:zookeeper][:data_dir]}" do
  owner user_name
  group group_name
  mode '00755'
  recursive true
  action :create
end

directory "#{node[:zookeeper][:journal_dir]}" do
  owner user_name
  group group_name
  mode '00755'
  recursive true
  action :create
end

directory "#{node[:zookeeper][:log_dir]}" do
  owner user_name
  group group_name
  mode '00755'
  recursive true
  action :create
end


# pull the remote file only if we create the directory
tarball = "zookeeper-#{node[:zookeeper][:version]}.tar.gz"
download_file = "#{node[:zookeeper][:mirror]}/zookeeper-#{node[:zookeeper][:version]}/#{tarball}"

remote_file "#{Chef::Config[:file_cache_path]}/#{tarball}" do
  source download_file
  mode 00644
  checksum node[:zookeeper][:checksum]
end

install_dir = node[:zookeeper][:install_dir]

execute "tar" do
  user  "root"
  group "root"
  cwd install_dir
  ## action :nothing
  command "tar zxvf #{Chef::Config[:file_cache_path]}/#{tarball}"
end


