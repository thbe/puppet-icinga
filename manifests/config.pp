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
    include icinga::config::server
  }
}
