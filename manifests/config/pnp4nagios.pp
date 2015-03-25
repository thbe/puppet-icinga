# Class: icinga::config::pnp4nagios
#
# This class contain the configuration for Icinga
#
# Parameters: This class has no parameters
#
class icinga::config::pnp4nagios {
  # Setup pnp4nagios server
  file {
    $icinga::params::configP4NConfig:
      ensure  => present,
      mode    => '0644',
      owner   => root,
      group   => root,
      path    => $icinga::params::configP4NConfig,
      content => template($icinga::params::configP4NConfigTemplate),
      require => Package[$icinga::params::packagePnp4Nagios];

    $icinga::params::configP4NPerfdata:
      ensure  => present,
      mode    => '0640',
      owner   => root,
      group   => root,
      path    => $icinga::params::configP4NPerfdata,
      content => template($icinga::params::configP4NPerfdataTemplate),
      require => Package[$icinga::params::packagePnp4Nagios];

    $icinga::params::configP4NHttp:
      ensure  => present,
      mode    => '0644',
      owner   => root,
      group   => root,
      path    => $icinga::params::configP4NHttp,
      content => template($icinga::params::configP4NHttpTemplate),
      require => Package[$icinga::params::packageApache];
  }

  # Setup password file for pnp4nagios
  exec { '/usr/bin/htpasswd -bc /etc/icinga/passwd root password':
    path   => '/bin:/sbin:/usr/bin:/usr/sbin',
    unless => 'test -f /etc/icinga/passwd'
  }
}
