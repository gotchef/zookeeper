# attributes/default.rb

# Install Info
default[:zookeeper][:version]     = '3.3.6'
default[:zookeeper][:checksum]    = 'eb311ec0479a9447d075a20350ecfc5cf6a2a6d9842d13b59d7548430ac37521'
default[:zookeeper][:mirror]      = 'http://download.nextag.com/apache/zookeeper'

# One of: 'runit', 'exhibitor'
default[:zookeeper][:service_style] = 'runit'

default[:zookeeper][:aws][:layer] = 'zookeeper'

#
# user
#
default[:zookeeper][:user]        = 'zookeeper'

#
# locations
#

default[:zookeeper][:install_dir]            = '/opt/zookeeper'
default[:zookeeper][:conf_dir]               = "/opt/zookeeper/zookeeper-#{node[:zookeeper][:version]}/conf"
default[:zookeeper][:conf_link_dir]          = '/etc/zookeeper'
default[:zookeeper][:log_dir]                = '/var/log/zookeeper'
default[:zookeeper][:pid_dir]                = '/var/run/zookeeper'


default[:zookeeper][:journal_dir]			= '/vol/zoo-txlog'
default[:zookeeper][:data_dir]				= '/vol/zoo-data'

default[:zookeeper][:client_port]            = '2181'
default[:zookeeper][:jmx_dash_port]          = '2182'
default[:zookeeper][:leader_port]            = '2888'
default[:zookeeper][:election_port]          = '3888'

default[:zookeeper][:env_vars] = {
	"JAVA_OPTS" => "-Xms128M -Xmx512M",
	"ZOO_LOG4J_PROP" => "INFO,ROLLINGFILE"
}


# == Environment Specific Settings

# IP => BrokerId
default[:zookeeper][:nodes] = {
	'127.0.0.1' => 1
}

# == Tunables

# the length of a single tick, which is the basic time unit used by ZooKeeper,
# as measured in milliseconds. It is used to regulate heartbeats, and
# timeouts. For example, the minimum session timeout will be two ticks.
default[:zookeeper][:tick_time] = 10000

# ZooKeeper logs transactions to a transaction log. After snapCount transactions
# are written to a log file a snapshot is started and a new transaction log file
# is created. The default snapCount is 100,000.
default[:zookeeper][:snapshot_trigger] = 10000

# Limits the number of concurrent connections (at the socket level) that a
# single client, identified by IP address, may make to a single member of the
# ZooKeeper ensemble. This is used to prevent certain classes of DoS attacks,
# including file descriptor exhaustion. The zookeeper default is 60; this file
# bumps that to 1000, but you will want to turn this up even more on a production
# machine. Setting this to 0 entirely removes the limit on concurrent
# connections.
default[:zookeeper][:max_client_connections] = 1000

# Time, in ticks, to allow followers to connect and sync to a leader. Increase
# if the amount of data managed by ZooKeeper is large
default[:zookeeper][:initial_timeout_ticks] = 100

# Time, in ticks, to allow followers to sync with ZooKeeper. If followers fall
# too far behind a leader, they will be dropped.
default[:zookeeper][:sync_timeout_ticks] = 100

# Should the leader accepts client connections? default "yes".  The leader
# machine coordinates updates. For higher update throughput at thes slight
# expense of read throughput the leader can be configured to not accept clients
# and focus on coordination. The default to this option is yes, which means that
# a leader will accept client connections. Turning on leader selection is highly
# recommended when you have more than three ZooKeeper servers in an ensemble.
#
# "auto" means "true if there are 4 or more zookeepers, false otherwise"
#
default[:zookeeper][:leader_is_also_server]  = 'yes'

#Sets the timeout value for opening connections for leader election notifications. 
default[:zookeeper][:cnxTimeout] = 50
