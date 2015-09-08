# Class: icinga::package::client
#
# This class contain the packages for Icinga 2 client installation
#
# Parameters:   This class has no parameters
#
class icinga::package::client {

  # Client relevant packages

  package { $icinga::params::packageNrpe: ensure => installed; }

  package { $icinga::params::packagePlugins: ensure => installed; }

  package { $icinga::params::packagePluginsPerl: ensure => installed; }

  package { $icinga::params::packagePluginsAll: ensure => installed; }
}
