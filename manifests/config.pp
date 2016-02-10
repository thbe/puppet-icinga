# Class: icinga::config
#
# This class contain the configuration for Icinga
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include icinga::config
#
class icinga::config {
  if $icinga::type == 'client' {
    include icinga::config::client
  }

  if $icinga::type == 'server' {
    include icinga::config::client
    include icinga::config::mysql
    include icinga::config::server
  }
}
