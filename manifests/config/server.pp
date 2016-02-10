# Class: icinga::config::server
#
# This class contain the server configuration for Icinga
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include icinga::config::server
#
class icinga::config::server {
  # Setup Icinga server features
  file { $icinga::params::config_icinga2_link_checker:
    ensure  => link,
    target  => $icinga::params::config_icinga2_feature_checker,
    require => Package[$icinga::params::package_icinga2];
  }

  file { $icinga::params::config_icinga2_link_command:
    ensure  => link,
    target  => $icinga::params::config_icinga2_feature_command,
    require => Package[$icinga::params::package_icinga2];
  }

  file { $icinga::params::config_icinga2_link_graphite:
    ensure  => link,
    target  => $icinga::params::config_icinga2_feature_graphite,
    require => Package[$icinga::params::package_icinga2];
  }

  file { $icinga::params::config_icinga2_link_ido_mysql:
    ensure  => link,
    target  => $icinga::params::config_icinga2_feature_ido_mysql,
    require => Package[$icinga::params::package_icinga2];
  }

  file { $icinga::params::config_icinga2_link_mainlog:
    ensure  => link,
    target  => $icinga::params::config_icinga2_feature_mainlog,
    require => Package[$icinga::params::package_icinga2];
  }

  file { $icinga::params::config_icinga2_link_notification:
    ensure  => link,
    target  => $icinga::params::config_icinga2_feature_notification,
    require => Package[$icinga::params::package_icinga2];
  }

  file { $icinga::params::config_icinga2_link_syslog:
    ensure  => link,
    target  => $icinga::params::config_icinga2_feature_syslog,
    require => Package[$icinga::params::package_icinga2];
  }

  # Setup Icingaweb2 server features
  file { $icinga::params::config_icingaweb2_enablemodules_directory:
    ensure  => directory,
    mode    => '2770',
    owner   => root,
    group   => icingaweb2,
    require => Package[$icinga::params::package_icingaweb2];
  }

  file { $icinga::params::config_icingaweb2_link_doc:
    ensure  => link,
    target  => $icinga::params::config_icingaweb2_feature_doc,
    require => Package[$icinga::params::package_icingaweb2];
  }

  file { $icinga::params::config_icingaweb2_link_monitoring:
    ensure  => link,
    target  => $icinga::params::config_icingaweb2_feature_monitoring,
    require => Package[$icinga::params::package_icingaweb2];
  }

  # Setup Icinga server puppet extensions
  file { $icinga::params::config_icinga2_conf_puppet_directory:
    ensure  => directory,
    mode    => '0750',
    owner   => icinga,
    group   => icinga,
    source  => $icinga::params::config_icinga2_conf_puppet_content,
    recurse => true,
    require => Package[$icinga::params::package_icinga2];
  }

  # Setup Icinga server custom extensions
  file { $icinga::params::config_icinga2_conf_custom_directory:
    ensure  => directory,
    mode    => '0750',
    owner   => icinga,
    group   => icinga,
    source  => $icinga::params::config_icinga2_conf_custom_content,
    recurse => true,
    require => Package[$icinga::params::package_icinga2];
  }

  # Include exported ressources if enabled
  if $icinga::exported_resources {
    Icinga::Config::Object::Host         <<| |>> { notify => Service[$icinga::params::service_icinga2] }
    Icinga::Config::Object::Hostextinfo  <<| |>> { notify => Service[$icinga::params::service_icinga2] }
    Icinga::Config::Object::Hostgroup    <<| |>> { notify => Service[$icinga::params::service_icinga2] }
    Icinga::Config::Object::Service      <<| |>> { notify => Service[$icinga::params::service_icinga2] }
    Icinga::Config::Object::Servicegroup <<| |>> { notify => Service[$icinga::params::service_icinga2] }
  }
}
