# Class: icinga::service
#
# This class contain the service configuration for Icinga
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

  if $icinga::type == 'client' {
    include ::icinga::service::client
  }

  if $icinga::type == 'server' {
    include ::icinga::service::client
    include ::icinga::service::server
  }
}
