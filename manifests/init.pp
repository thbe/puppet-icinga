# == Class: icinga
#
# This is the icinga module. This module install all things
# required to setup icinga.
#
# === Parameters
#
# Here is the list of parameters used by this module.
#
# [*client*]
#   Specify if client components should be installed (not implemented yet)
#   Default value is false
#
# [*server*]
#   Specify if server components should be installed
#   Default value is false
#
# [*plugins*]
#   Specify one or more plugins that should be installed
#   Default value is none (not implemented yet)
#
# [*exportedRessources*]
#   Specify if exported resources should be used
#   Default value is false (not implemented yet)
#
# === Variables
#
# No additonal variables are required for this module
#
# === Examples
#
#  class { '::icinga':
#    client  => true,
#    plugins => [ 'http', 'ssh' ],
#  }
#
# === Authors
#
# Thomas Bendler <project@bendler-net.de>
#
# === Copyright
#
# Copyright 2015 Thomas Bendler, unless otherwise noted.
#
class icinga (
  $client            = $icinga::params::client,
  $server            = $icinga::params::server,
  $plugins           = $icinga::params::plugins,
  $exportedResources = $icinga::params::exportedResources,
  ) inherits icinga::params {

  # Require class yum to have the relevant repositories in place
  class { '::yum':
    repoIcinga => "yes",
  }

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
}
