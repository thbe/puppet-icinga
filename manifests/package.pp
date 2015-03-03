# Class: icinga::package
#
# This class contain the service configuration for Icinga
#
# Parameters:   This class has no parameters
#
class icinga::package {

  # Common packages

  package { $icinga::params::packagePlugins: ensure => installed; }

  package { $icinga::params::packagePluginsPerl: ensure => installed; }

  package { $icinga::params::packagePluginsAll: ensure => installed; }

  if $icinga::client {
    include icinga::package::client
  }

  if $icinga::server {
    include icinga::package::server
  }
}
