# Class: icinga::package::client
#
# This class contain the service configuration for Icinga
#
# Parameters:   This class has no parameters
#
class icinga::package::client {

  # Client relevant packages

  package { $icinga::params::packageNrpe: ensure => installed; }
}
