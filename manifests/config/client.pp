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
    if $::kernel == 'Linux' {
      $icinga_hostgroup = $::hostgroup ? {
        storage => 'puppet,linux,storage',
        sap     => 'puppet,linux,sap',
        default => 'puppet,linux'
        }
      $icinga_host_template        = 'linux-server'
      $icinga_service_template     = 'linux-service'
      #$icinga_service_notification = '24x7'
      $icinga_service_notification = 'workhours'
      $icinga_service_groups       = 'puppet,base'
    }

    @@nagios_host { $::fqdn:
      ensure     => present,
      alias      => $::hostname,
      address    => $::ipaddress,
      use        => $icinga_template,
      hostgroups => $icinga_hostgroup,
      target     => "${icinga::params::configPuppetRessourceDirectory}/${::fqdn}_host.cfg";
    }

    @@nagios_hostextinfo { $::fqdn:
      ensure          => present,
      icon_image_alt  => $::operatingsystem,
      icon_image      => "${icinga::params::iconfile}.png",
      statusmap_image => "${icinga::params::iconfile}.gd2",
      target          => "${icinga::params::configPuppetRessourceDirectory}/${::fqdn}_host_ext.cfg"
    }

    @@nagios_service { "check-host-alive_${::hostname}":
      check_command       => 'check-host-alive!100.0,20%!500.0,60%',
      use                 => $icinga_service_template,
      host_name           => $::fqdn,
      notification_period => $icinga_service_notification,
      servicegroups       => $icinga_service_groups,
      service_description => "${::hostname}_check-host-alive",
      target              => "${icinga::params::configPuppetRessourceDirectory}/${::fqdn}_service_host_alive.cfg",
      require             => Nagios_host[$::fqdn];
    }

    @@nagios_service { "check_nrpe_users_${::hostname}":
      check_command       => 'check_nrpe!check_users',
      use                 => $icinga_service_template,
      host_name           => $::fqdn,
      notification_period => $icinga_service_notification,
      servicegroups       => $icinga_service_groups,
      service_description => "${::hostname}_check_nrpe_users",
      target              => "${icinga::params::configPuppetRessourceDirectory}/${::fqdn}_service_users.cfg",
      require             => Nagios_host[$::fqdn];
    }

    @@nagios_service { "check_nrpe_load_${::hostname}":
      check_command       => 'check_nrpe!check_load',
      use                 => $icinga_service_template,
      host_name           => $::fqdn,
      notification_period => $icinga_service_notification,
      servicegroups       => $icinga_service_groups,
      service_description => "${::hostname}_check_nrpe_load",
      target              => "${icinga::params::configPuppetRessourceDirectory}/${::fqdn}_service_load.cfg",
      require             => Nagios_host[$::fqdn];
    }

    @@nagios_service { "check_nrpe_procs_${::hostname}":
      check_command       => 'check_nrpe!check_procs',
      use                 => $icinga_service_template,
      host_name           => $::fqdn,
      notification_period => $icinga_service_notification,
      servicegroups       => $icinga_service_groups,
      service_description => "${::hostname}_check_nrpe_procs",
      target              => "${icinga::params::configPuppetRessourceDirectory}/${::fqdn}_service_procs.cfg",
      require             => Nagios_host[$::fqdn];
    }

    @@nagios_service { "check_nrpe_procs_zombies_${::hostname}":
      check_command       => 'check_nrpe!check_procs_zombies',
      use                 => $icinga_service_template,
      host_name           => $::fqdn,
      notification_period => $icinga_service_notification,
      servicegroups       => $icinga_service_groups,
      service_description => "${::hostname}_check_nrpe_procs_zombies",
      target              => "${icinga::params::configPuppetRessourceDirectory}/${::fqdn}_service_zombies.cfg",
      require             => Nagios_host[$::fqdn];
    }

    @@nagios_service { "check_nrpe_disk_root_${::hostname}":
      check_command       => 'check_nrpe!check_disk_root',
      use                 => $icinga_service_template,
      host_name           => $::fqdn,
      notification_period => $icinga_service_notification,
      servicegroups       => $icinga_service_groups,
      service_description => "${::hostname}_check_nrpe_disk_root",
      target              => "${icinga::params::configPuppetRessourceDirectory}/${::fqdn}_service_disk_root.cfg",
      require             => Nagios_host[$::fqdn];
    }

    @@nagios_service { "check_nrpe_disk_boot_${::hostname}":
      check_command       => 'check_nrpe!check_disk_boot',
      use                 => $icinga_service_template,
      host_name           => $::fqdn,
      notification_period => $icinga_service_notification,
      servicegroups       => $icinga_service_groups,
      service_description => "${::hostname}_check_nrpe_disk_boot",
      target              => "${icinga::params::configPuppetRessourceDirectory}/${::fqdn}_service_disk_boot.cfg",
      require             => Nagios_host[$::fqdn];
    }

    @@nagios_service { "check_nrpe_swap_${::hostname}":
      check_command       => 'check_nrpe!check_swap',
      use                 => $icinga_service_template,
      host_name           => $::fqdn,
      notification_period => $icinga_service_notification,
      servicegroups       => $icinga_service_groups,
      service_description => "${::hostname}_check_nrpe_swap",
      target              => "${icinga::params::configPuppetRessourceDirectory}/${::fqdn}_service_swap.cfg",
      require             => Nagios_host[$::fqdn];
    }

    @@nagios_service { "check_ssh_${::hostname}":
      check_command       => 'check_nrpe!check_ssh',
      use                 => $icinga_service_template,
      host_name           => $::fqdn,
      notification_period => $icinga_service_notification,
      servicegroups       => $icinga_service_groups,
      service_description => "${::hostname}_check_ssh",
      target              => "${icinga::params::configPuppetRessourceDirectory}/${::fqdn}_service_ssh.cfg",
      require             => Nagios_host[$::fqdn];
    }
  }
}
