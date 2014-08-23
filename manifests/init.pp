# == Class: icinga
#
# Full description of class icinga here.
#
# === Parameters
#
# Document parameters here.
#
# [*plugins*]
#   Specify one or more plugins that should be installed
#   Default value is all
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { icinga:
#    plugins => [ 'http', 'ssh' ],
#  }
#
# === Authors
#
# Thomas Bendler <project@bendler-net.de>
#
# === Copyright
#
# Copyright 2014 Thomas Bendler, unless otherwise noted.
#
class icinga (
  $plugins = $icinga::params::plugins,
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
