# Class: icinga::config
#
# This class contain the configuration for Icinga
#
# Parameters: This class has no parameters
#
class icinga::config {
  if $icinga::type == 'client' {
    include icinga::config::client
  }

  if $icinga::type == 'server' {
    include icinga::config::mysql
    include icinga::config::server
    include icinga::config::web2
    include icinga::config::pnp4nagios
  }
}
