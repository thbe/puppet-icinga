# Class: icinga::install::server
#
# This class contain the packages for Icinga 2 server installation
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage:
#
class icinga::install::server {

  # Server relevant packages
  package { $icinga::params::package_icinga2:           ensure => installed; }
  package { $icinga::params::package_icingacli:         ensure => installed; }
  package { $icinga::params::package_icingaweb2:        ensure => installed; }
  package { $icinga::params::package_httpd:             ensure => installed; }
  package { $icinga::params::package_icinga2_ido_mysql: ensure => installed; }
  package { $icinga::params::package_php:               ensure => installed; }
  package { $icinga::params::package_php_mysql:         ensure => installed; }
  package { $icinga::params::package_php_ldap:          ensure => installed; }
  package { $icinga::params::package_php_gd:            ensure => installed; }
  package { $icinga::params::package_net_snmp:          ensure => installed; }
  package { $icinga::params::package_net_snmp_devel:    ensure => installed; }
  package { $icinga::params::package_net_snmp_utils:    ensure => installed; }
  package { $icinga::params::package_rrdtool:           ensure => installed; }
  package { $icinga::params::package_rrdtool_perl:      ensure => installed; }
}
