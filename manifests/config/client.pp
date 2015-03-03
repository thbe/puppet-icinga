# Class: icinga::config::client
#
# This class contain the configuration for Icinga
#
# Parameters: This class has no parameters
#
class icinga::config::client {

  # Setup NRPE client
  file {
    $icinga::params::configNrpeConfig:
      ensure  => present,
      mode    => '0644',
      owner   => root,
      group   => root,
      path    => $icinga::params::configNrpeConfig,
      content => template($icinga::params::configNrpeConfigTemplate),
      require => Package[$icinga::params::packageNrpe];

    $icinga::params::configNrpeConfigBase:
      ensure  => present,
      mode    => '0644',
      owner   => root,
      group   => root,
      path    => $icinga::params::configNrpeConfigBase,
      content => template($icinga::params::configNrpeConfigBaseTemplate),
      require => Package[$icinga::params::packageNrpe];
  }

  # Include exported ressources if enabled
  if $icinga::exportedResources {
    # to be done
  }
}
