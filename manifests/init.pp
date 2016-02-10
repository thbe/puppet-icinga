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
# * `plugins`
#   Specify one or more plugins that should be installed
#   Default value is none (not implemented yet)
#
# * `exported_ressources`
#   Specify if exported resources should be used
#   Default value is false (not implemented yet)
#
# * `server_acl`
#   Specify the Icinga servers that are allowed to access monitoring client
#   Default value is 127.0.0.1
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
  $type               = 'client',
  $server_acl         = '127.0.0.1',
  $plugins            = ['none'],
  $exported_resources = false,
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
