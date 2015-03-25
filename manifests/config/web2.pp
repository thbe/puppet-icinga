# Class: icinga::config::web2
#
# This class contain the configuration for Icinga
#
# Parameters: This class has no parameters
#
class icinga::config::web2 {

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
}
