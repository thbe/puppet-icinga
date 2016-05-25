# Class: icinga
# ===========================
#
# This is the icinga module. This module install all things
# required to setup Icinga 2.
#
# Parameters
# ----------
#
# Here is the list of parameters used by this module.
#
# * `type`
#   Specify if client or server components should be installed
#   Default value is client
#
# * `server_acl`
#   Specify the Icinga servers that are allowed to access monitoring client
#   Default value is 127.0.0.1
#
# * `plugins`
#   Specify one or more plugins that should be installed
#   Default value is none (not implemented yet)
#
# * `exported_ressources`
#   Specify if exported resources should be used
#   Default value is false
#
# * `exported_sla`
#   Specify the sla for the resource that should be used
#   Default value is 24x7
#
# Variables
# ----------
#
# No additonal variables are required for this module
#
# Examples
# --------
#
# @example
#    class { 'icinga':
#      type => 'client',
#    }
#
# Authors
# -------
#
# Thomas Bendler <project@bendler-net.de>
#
# Copyright
# ---------
#
# Copyright 2016 Thomas Bendler, unless otherwise noted.
#
class icinga (
  $type               = $icinga::params::type,
  $server_acl         = $icinga::params::server_acl,
  $plugins            = $icinga::params::plugins,
  $exported_resources = $icinga::params::exported_resources,
  $exported_sla       = $icinga::params::exported_sla
) inherits icinga::params {

  # Start workflow
  if $icinga::params::linux {
    # Containment
    contain icinga::package
    contain icinga::config
    contain icinga::service

    # Include classes
    Class['icinga::package'] ->
    Class['icinga::config'] ->
    Class['icinga::service']
  }
  else {
    warning('The current operating system is not supported!')
  }
}
