# Main entry for puppet
#
# import is depricated and we should use another method for including these
#+ manifests
#

import 'apache.pp'
import 'mysql.pp'
import 'fluentd.pp'
import 'nubis_configuration.pp'
#include nubis_configuration

exec { "apt-get update":
    command => "/usr/bin/apt-get update",
    onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
}

package { 'php-apc':
  ensure => '4.0.2-2build1',
  require  => Exec['apt-get update'],
}

package { 'php5-gd':
  ensure => '5.5.9+dfsg-1ubuntu4.6',
  require  => Exec['apt-get update'],
}

package { 'php5-mysql':
  ensure => '5.5.9+dfsg-1ubuntu4.6',
  require  => Exec['apt-get update'],
}

package { 'makepasswd':
  ensure => '1.10-9',
  require  => Exec['apt-get update'],
}