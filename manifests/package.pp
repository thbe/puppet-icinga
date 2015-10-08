# Class: icinga::package
#
# This class contain the service configuration for Icinga
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include icinga::package
#
class icinga::package {

  if $icinga::type == 'client' {
    include icinga::package::client
  }

  if $icinga::type == 'server' {
    include icinga::package::client
    include icinga::package::server
  }
}
