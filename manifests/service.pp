# Class: icinga::service
#
# This class contain the service configuration for Icinga
#
# Parameters:   This class has no parameters
#
class icinga::service {

  if $icinga::client {
    #include icinga::service::client
  }

  if $icinga::server {
    include icinga::service::server
  }
}
