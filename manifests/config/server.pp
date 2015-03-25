# Class: icinga::config::server
#
# This class contain the configuration for Icinga
#
# Parameters: This class has no parameters
#
class icinga::config::server {
  # Setup Icinga server
  file {
    $icinga::params::configIcinga2LinkChecker:
      ensure  => link,
      mode    => '0775',
      owner   => icinga,
      group   => icinga,
      path    => $icinga::params::configIcinga2FeatureChecker,
      require => Package[$icinga::params::packageCommon];

    $icinga::params::configIcinga2LinkIdoMysql:
      ensure  => link,
      mode    => '0775',
      owner   => icinga,
      group   => icinga,
      path    => $icinga::params::configIcinga2FeatureIdoMysql,
      require => Package[$icinga::params::packageCommon];

    $icinga::params::configIcinga2LinkMainlog:
      ensure  => link,
      mode    => '0775',
      owner   => icinga,
      group   => icinga,
      path    => $icinga::params::configIcinga2FeatureMainlog,
      require => Package[$icinga::params::packageCommon];

    $icinga::params::configIcinga2LinkNotification:
      ensure  => link,
      mode    => '0775',
      owner   => icinga,
      group   => icinga,
      path    => $icinga::params::configIcinga2FeatureNotification,
      require => Package[$icinga::params::packageCommon];

    $icinga::params::configIcinga2LinkPerfdata:
      ensure  => link,
      mode    => '0775',
      owner   => icinga,
      group   => icinga,
      path    => $icinga::params::configIcinga2FeaturePerfdata,
      require => Package[$icinga::params::packageCommon];
  }

  # Include exported ressources if enabled
  if $icinga::exportedResources {
    file {
      $icinga::params::configPuppetRessourceDirectory:
        ensure  => directory,
        mode    => '0755',
        owner   => root,
        group   => root,
        require => Package[$icinga::params::packageCommon];
    }

    Nagios_host         <<| |>> { notify => Service[$icinga::params::serviceCommon] }
    Nagios_hostextinfo  <<| |>> { notify => Service[$icinga::params::serviceCommon] }
    Nagios_hostgroup    <<| |>> { notify => Service[$icinga::params::serviceCommon] }
    Nagios_service      <<| |>> { notify => Service[$icinga::params::serviceCommon] }
    Nagios_servicegroup <<| |>> { notify => Service[$icinga::params::serviceCommon] }
  }
}
