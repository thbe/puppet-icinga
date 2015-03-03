# Class: icinga::service::client
#
# This class contain the service configuration for Icinga
#
# Parameters:   This class has no parameters
#
class icinga::service::client {

  # Icinga service configuration
  service {
    $icinga::params::serviceNrpe:
      ensure  => 'running',
      enable  => true,
      require => Package[$icinga::params::packageNrpe];
  }
}
