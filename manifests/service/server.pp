# Class: icinga::service::server
#
# This class contain the service configuration for Icinga
#
# Parameters:   This class has no parameters
#
class icinga::service::server {

  # Icinga service configuration
  service {
    $icinga::params::serviceCommon:
      ensure  => 'running',
      enable  => true,
      require => Package[$icinga::params::packageCommon];

    $icinga::params::serviceApache:
      ensure  => 'running',
      enable  => true,
      require => Package[$icinga::params::packageApache];
  }
}
