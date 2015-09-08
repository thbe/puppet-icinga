# Class: icinga::package
#
# This class contain the service configuration for Icinga
#
# Parameters:   This class has no parameters
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
