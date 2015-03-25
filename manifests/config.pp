# Class: icinga::config
#
# This class contain the configuration for Icinga
#
# Parameters: This class has no parameters
#
class icinga::config {
  if $icinga::client {
    include icinga::config::client
  }

  if $icinga::server {
    include icinga::config::mysql
    include icinga::config::server
    include icinga::config::web2
    include icinga::config::pnp4nagios
  }
}
