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
# Copyright 2017 Thomas Bendler, unless otherwise noted.
#
class icinga (
  $type               = $icinga::params::type,
  $server_acl         = $icinga::params::server_acl,
  $plugins            = $icinga::params::plugins,
  $exported_resources = $icinga::params::exported_resources,
  $exported_sla       = $icinga::params::exported_sla
) inherits icinga::params {

  # Validate parameters
  include ::stdlib
  validate_string($icinga::type)
  validate_string($icinga::server_acl)
  validate_array($icinga::plugins)
  validate_bool($icinga::exported_resources)
  validate_string($icinga::exported_sla)

  if $type != client {
    if $type != server {
      $type = $icinga::params::type
      warning('Not supported icinga type, switch back to default value!')
    }
  }

  # Start workflow
  if $icinga::params::linux {
    class{ '::icinga::install': }
    -> class{ '::icinga::config': }
    ~> class{ '::icinga::service': }
    -> Class['icinga']
  }
  else {
    warning('The current operating system is not supported!')
  }
}
