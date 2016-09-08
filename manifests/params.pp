# Class: icinga::params
#
# This class contain the parameters for Icinga
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include icinga::params
#
class icinga::params {

  # Operating system specific definitions
  case $::osfamily {
    'RedHat' : {
      if $::operatingsystemmajrelease == '7' {
        $linux                                    = true
      } else {
        $linux                                    = false
      }

      # Package definition
      $package_icinga2                            = 'icinga2'
      $package_icinga2_bin                        = 'icinga2-bin'
      $package_icingacli                          = 'icingacli'
      $package_icingaweb2                         = 'icingaweb2'
      $package_httpd                              = 'httpd'
      $package_icinga2_ido_mysql                  = 'icinga2-ido-mysql'
      $package_nagios_plugins                     = 'nagios-plugins'
      $package_nagios_plugins_perl                = 'nagios-plugins-perl'
      $package_nagios_plugins_all                 = 'nagios-plugins-all'
      $package_php                                = 'php'
      $package_php_mysql                          = 'php-mysql'
      $package_php_ldap                           = 'php-ldap'
      $package_php_gd                             = 'php-gd'
      $package_net_snmp                           = 'net-snmp'
      $package_net_snmp_devel                     = 'net-snmp-devel'
      $package_net_snmp_utils                     = 'net-snmp-utils'
      $package_rrdtool                            = 'rrdtool'
      $package_rrdtool_perl                       = 'rrdtool-perl'
      $package_nrpe                               = 'nrpe'

      # Config definition
      $config_icinga2_ido_mysql                   = '/etc/icinga2/features-available/ido-mysql.conf'
      $config_icinga2_ido_mysql_template          = 'icinga/etc/icinga2/features-available/ido-mysql.conf.erb'
      $config_icinga2_conf_puppet_directory       = '/etc/icinga2/conf.d/puppet'
      $config_icinga2_conf_puppet_content         = 'puppet:///modules/icinga/puppet/'
      $config_icinga2_conf_custom_directory       = '/etc/icinga2/conf.d/custom'
      $config_icinga2_conf_custom_content         = 'puppet:///modules/icinga/custom/'
      $config_schema_script                       = '/etc/icinga2/populate_icinga_schema.sh'
      $config_schema_script_file                  = 'puppet:///modules/icinga/schema/populate_icinga_schema.sh'
      $config_admin_user_script                   = '/etc/icinga2/icingaadmin.sql'
      $config_admin_user_script_file              = 'puppet:///modules/icinga/schema/icingaadmin.sql'

      $config_icinga2_link_checker                = '/etc/icinga2/features-enabled/checker.conf'
      $config_icinga2_feature_checker             = '../features-available/checker.conf'
      $config_icinga2_link_command                = '/etc/icinga2/features-enabled/command.conf'
      $config_icinga2_feature_command             = '../features-available/command.conf'
      $config_icinga2_link_graphite               = '/etc/icinga2/features-enabled/graphite.conf'
      $config_icinga2_feature_graphite            = '../features-available/graphite.conf'
      $config_icinga2_link_ido_mysql              = '/etc/icinga2/features-enabled/ido-mysql.conf'
      $config_icinga2_feature_ido_mysql           = '../features-available/ido-mysql.conf'
      $config_icinga2_link_mainlog                = '/etc/icinga2/features-enabled/mainlog.conf'
      $config_icinga2_feature_mainlog             = '../features-available/mainlog.conf'
      $config_icinga2_link_notification           = '/etc/icinga2/features-enabled/notification.conf'
      $config_icinga2_feature_notification        = '../features-available/notification.conf'
      $config_icinga2_link_syslog                 = '/etc/icinga2/features-enabled/syslog.conf'
      $config_icinga2_feature_syslog              = '../features-available/syslog.conf'

      $config_icingaweb2_enablemodules_directory  = '/etc/icingaweb2/enabledModules'
      $config_icingaweb2_link_doc                 = '/etc/icingaweb2/enabledModules/doc'
      $config_icingaweb2_feature_doc              = '/usr/share/icingaweb2/modules/doc'
      $config_icingaweb2_link_monitoring          = '/etc/icingaweb2/enabledModules/monitoring'
      $config_icingaweb2_feature_monitoring       = '/usr/share/icingaweb2/modules/monitoring'

      $config_nrpe_config                         = '/etc/nagios/nrpe.cfg'
      $config_nrpe_config_template                = 'icinga/etc/nagios/nrpe.cfg.erb'
      $config_nrpe_config_base                    = '/etc/nrpe.d/base.cfg'
      $config_nrpe_config_base_template           = 'icinga/etc/nrpe.d/base.cfg.erb'


      # Service definition
      $service_icinga2                            = 'icinga2'
      $service_nrpe                               = 'nrpe'
      $service_httpd                              = 'httpd'
    }
    default  : {
      $linux                                      = false
    }
  }

  # Standard Icinga settings
  $type               = 'client'
  $server_acl         = '127.0.0.1'
  $plugins            = ['none']
  $exported_resources = false
  $exported_sla       = '24x7'
}
