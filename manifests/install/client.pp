# Class: icinga::c::client
#
# This class contain the packages for Icinga 2 client installation
#
# Parameters:   This class has no parameters
#
# Actions:      This class has no actions
#
# Requires:     This class has no requirements
#
# Sample Usage:
#
class icinga::install::client {

  # Client relevant packages
  package { $icinga::params::package_icinga2_bin:         ensure => installed; }
  package { $icinga::params::package_nagios_plugins:      ensure => installed; }
  package { $icinga::params::package_nagios_plugins_perl: ensure => installed; }
  package { $icinga::params::package_nagios_plugins_all:  ensure => installed; }
}
