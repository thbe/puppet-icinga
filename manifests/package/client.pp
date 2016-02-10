# Class: icinga::package::client
#
# This class contain the packages for Icinga 2 client installation
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include icinga::package::client
#
class icinga::package::client {

  # Client relevant packages
  package { $icinga::params::package_nrpe:                ensure => installed; }
  package { $icinga::params::package_nagios_plugins:      ensure => installed; }
  package { $icinga::params::package_nagios_plugins_perl: ensure => installed; }
  package { $icinga::params::package_nagios_plugins_all:  ensure => installed; }
}
