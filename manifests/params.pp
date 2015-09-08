# Class: icinga::params
#
# This class contain the parameters for Icinga
#
# Parameters: This class has no parameters
#
class icinga::params {

  # Operating system specific definitions
  case $::osfamily {
    'RedHat' : {
      $linux                                   = true

      # Package definition
      $packageCommon                           = 'icinga2'
      $packageCommonCli                        = 'icingacli'
      $packageCommonWeb                        = 'icingaweb2'
      $packageNrpe                             = 'nrpe'
      $packageApache                           = 'httpd'
      $packageIdoMysql                         = 'icinga2-ido-mysql'
      $packagePlugins                          = 'nagios-plugins'
      $packagePluginsPerl                      = 'nagios-plugins-perl'
      $packagePluginsAll                       = 'nagios-plugins-all'
      $packagePhpCommon                        = 'php'
      $packagePhpMysql                         = 'php-mysql'
      $packagePhpLdap                          = 'php-ldap'
      $packagePhpGd                            = 'php-gd'
      $packageNetSnmp                          = 'net-snmp'
      $packageNetSnmpDevel                     = 'net-snmp-devel'
      $packageNetSnmpUtils                     = 'net-snmp-utils'
      $packageRrdTool                          = 'rrdtool'
      $packageRrdToolPerl                      = 'rrdtool-perl'
      $packagePnp4Nagios                       = 'pnp4nagios'
      $packageIcingaWebPnp                     = 'icinga-web-module-pnp'

      # Config definition
      $configIcinga2IdoMysql                   = '/etc/icinga2/features-available/ido-mysql.conf'
      $configIcinga2IdoMysqlTemplate           = 'icinga/etc/icinga2/features-available/ido-mysql.conf.erb'
      $configIcinga2ConfDirectoryPuppet        = '/etc/icinga2/conf.d/puppet'
      $configIcinga2ExtensionsDirectoryPuppet  = '/etc/icinga2/conf.d/puppet/extensions'
      $configIcinga2ConfDirectoryCustom        = '/etc/icinga2/conf.d/custom'
      $configIcinga2FeatureDirectory           = '/etc/icinga2/features-enabled'
      $configIcinga2LinkChecker                = 'checker.conf'
      $configIcinga2FeatureChecker             = '../features-available/checker.conf'
      $configIcinga2LinkIdoMysql               = 'ido-mysql.conf'
      $configIcinga2FeatureIdoMysql            = '../features-available/ido-mysql.conf'
      $configIcinga2LinkMainlog                = 'mainlog.conf'
      $configIcinga2FeatureMainlog             = '../features-available/mainlog.conf'
      $configIcinga2LinkNotification           = 'notification.conf'
      $configIcinga2FeatureNotification        = '../features-available/notification.conf'
      $configIcinga2LinkPerfdata               = 'perfdata.conf'
      $configIcinga2FeaturePerfdata            = '../features-available/perfdata.conf'
      $configIcingaweb2LinkDoc                 = 'doc'
      $configIcingaweb2FeatureDoc              = '/usr/share/icingaweb2/modules/doc'
      $configIcingaweb2LinkMonitoring          = 'monitoring'
      $configIcingaweb2FeatureMonitoring       = '/usr/share/icingaweb2/modules/monitoring'
      $configP4NConfig                         = '/etc/pnp4nagios/config.php'
      $configP4NConfigTemplate                 = 'icinga/etc/pnp4nagios/config.php.erb'
      $configP4NPerfdata                       = '/etc/pnp4nagios/process_perfdata.cfg'
      $configP4NPerfdataTemplate               = 'icinga/etc/pnp4nagios/process_perfdata.cfg.erb'
      $configP4NHttp                           = '/etc/httpd/conf.d/pnp4nagios.conf'
      $configP4NHttpTemplate                   = 'icinga/etc/httpd/conf.d/pnp4nagios.conf.erb'
      $configNrpeConfig                        = '/etc/nagios/nrpe.cfg'
      $configNrpeConfigTemplate                = 'icinga/etc/nagios/nrpe.cfg.erb'
      $configNrpeConfigBase                    = '/etc/nrpe.d/base.cfg'
      $configNrpeConfigBaseTemplate            = 'icinga/etc/nrpe.d/base.cfg.erb'
      $configPuppetRessourceDirectory          = '/etc/icinga2/conf.d/puppet'
      $configSchemaScript                      = '/etc/icinga2/populate_icinga_schema.sh'
      $configSchemaScriptFile                  = 'puppet:///modules/icinga/schema/populate_icinga_schema.sh'
      $configServiceExtension                  = '/etc/icinga2/conf.d/puppet/extensions/service.conf'
      $configServiceExtensionFile              = 'puppet:///modules/icinga/extensions/service.conf'

      # Service definition
      $serviceCommon                           = 'icinga2'
      $serviceNrpe                             = 'nrpe'
      $serviceApache                           = 'httpd'
    }
    default  : {
      $linux                                   = false
    }
  }
}
