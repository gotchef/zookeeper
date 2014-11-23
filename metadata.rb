name             'zookeeper'
maintainer       'Krave-n, Inc.'
maintainer_email 'dev-ops@krave-n.com'
license          'Copyright 2014, Krave-n, Inc'
description      'Installs/Configures zookeeper'
version          '2.4.1'

depends          'build-essential', '>= 2.0.2'
depends          'java'
depends          'runit'

recipe           "zookeeper::service",                 "Installs zookeeper as a service that always runs"
recipe           "zookeeper::default",                 "Installs Zookeeper server, sets up and starts service"
recipe           "zookeeper::install",                 "Install zookeeper"
recipe           "zookeeper::configure",            "Config files -- include this last after discovery"


