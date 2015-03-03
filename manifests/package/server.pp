# Class: icinga::package::server
#
# This class contain the service configuration for Icinga
#
# Parameters:   This class has no parameters
#
class icinga::package::server {

  # Server relevant packages

  package { $icinga::params::packageCommon: ensure => installed; }

  package { $icinga::params::packageCommonWeb: ensure => installed; }

  package { $icinga::params::packageApache: ensure => installed; }

  package { $icinga::params::packageIdoMysql: ensure => installed; }

  package { $icinga::params::packageIdoutilsMysql: ensure => installed; }

  package { $icinga::params::packagePhpCommon: ensure => installed; }

  package { $icinga::params::packagePhpMysql: ensure => installed; }

  package { $icinga::params::packagePhpLdap: ensure => installed; }

  package { $icinga::params::packagePhpGd: ensure => installed; }

  package { $icinga::params::packageNetSnmp: ensure => installed; }

  package { $icinga::params::packageNetSnmpDevel: ensure => installed; }

  package { $icinga::params::packageNetSnmpUtils: ensure => installed; }

  package { $icinga::params::packageRrdTool: ensure => installed; }

  package { $icinga::params::packageRrdToolPerl: ensure => installed; }

  package { $icinga::params::packagePnp4Nagios: ensure => installed; }

  package { $icinga::params::packageIcingaWebPnp: ensure => installed; }
}
