# Class: icinga::service::server
#
# This class contain the service configuration for Icinga
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include icinga::service::server
#
class icinga::service::server {

  # Icinga service configuration
  service { $icinga::params::service_icinga2:
    ensure  => 'running',
    enable  => true,
    require => Package[$icinga::params::package_icinga2];
  }

  service { $icinga::params::service_httpd:
    ensure  => 'running',
    enable  => true,
    require => Package[$icinga::params::package_httpd];
  }
}
