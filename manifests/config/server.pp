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

    $icinga::params::configIcinga2ConfDirectoryCustom:
      ensure  => directory,
      mode    => '0750',
      owner   => icinga,
      group   => icinga,
      path    => $icinga::params::configIcinga2ConfDirectoryCustom,
      require => Package[$icinga::params::packageCommon];

    $icinga::params::configIcinga2ConfDirectoryPuppet:
      ensure  => directory,
      mode    => '0750',
      owner   => icinga,
      group   => icinga,
      path    => $icinga::params::configIcinga2ConfDirectoryPuppet,
      require => Package[$icinga::params::packageCommon];

    $icinga::params::configIcinga2ExtensionsDirectoryPuppet:
      ensure  => directory,
      mode    => '0750',
      owner   => icinga,
      group   => icinga,
      path    => $icinga::params::configIcinga2ExtensionsDirectoryPuppet,
      require => Package[$icinga::params::packageCommon];

    $icinga::params::configServiceExtension:
      ensure  => present,
      mode    => '0640',
      owner   => icinga,
      group   => icinga,
      path    => $icinga::params::configServiceExtension,
      source  => $icinga::params::configServiceExtensionFile,
      require => Package[$icinga::params::packageCommon];
  }

  # Setup Icinga 2 web server
  file {
    $icinga::params::configIcingaweb2LinkDoc:
      ensure  => link,
      mode    => '0775',
      owner   => icinga,
      group   => icinga,
      path    => $icinga::params::configIcingaweb2FeatureDoc,
      require => Package[$icinga::params::packageCommonWeb];

    $icinga::params::configIcingaweb2LinkMonitoring:
      ensure  => link,
      mode    => '0775',
      owner   => icinga,
      group   => icinga,
      path    => $icinga::params::configIcingaweb2FeatureMonitoring,
      require => Package[$icinga::params::packageCommonWeb];
  }

  # Include exported ressources if enabled
  if $icinga::exportedResources {
    Nagios_host         <<| |>> { notify => Service[$icinga::params::serviceCommon] }
    Nagios_hostextinfo  <<| |>> { notify => Service[$icinga::params::serviceCommon] }
    Nagios_hostgroup    <<| |>> { notify => Service[$icinga::params::serviceCommon] }
    Nagios_service      <<| |>> { notify => Service[$icinga::params::serviceCommon] }
    Nagios_servicegroup <<| |>> { notify => Service[$icinga::params::serviceCommon] }
  }
}
