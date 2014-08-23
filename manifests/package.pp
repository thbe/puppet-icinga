# Class: icinga::package
#
# This module contain the service configuration for Icinga
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include icinga::package
#
class icinga::package {
  package { $icinga::params::packageCommon: ensure => installed; }
  package { $icinga::params::packageCommonWeb: ensure => installed; }
  package { $icinga::params::packageApache: ensure => installed; }
  package { $icinga::params::packageIdoMysql: ensure => installed; }
  package { $icinga::params::packageIdoutilsMysql: ensure => installed; }
  package { $icinga::params::packagePlugins: ensure => installed; }
  package { $icinga::params::packagePluginsAll: ensure => installed; }
  package { $icinga::params::packagePhpCommon: ensure => installed; }
  package { $icinga::params::packagePhpMysql: ensure => installed; }
  package { $icinga::params::packagePhpLdap: ensure => installed; }
  package { $icinga::params::packagePhpGd: ensure => installed; }
}
