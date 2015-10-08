# Class: icinga::service::client
#
# This class contain the service configuration for Icinga
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include icinga::service::client
#
class icinga::service::client {

  # Icinga service configuration
  service {
    $icinga::params::service_nrpe:
      ensure  => 'running',
      enable  => true,
      require => Package[$icinga::params::package_nrpe];
  }
}
