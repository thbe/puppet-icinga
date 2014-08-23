# Class: icinga::service
#
# This module contain the service configuration for Icinga
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include icinga::service
#
class icinga::service {

  # Icinga service configuration
  service { $icinga::params::serviceCommon:
    ensure  => 'running',
    enable  => true,
    require => Package[$icinga::params::packageCommon];
  }
}
