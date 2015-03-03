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
      $linux                        = true

      # Package definition
      $packageCommon                = 'icinga2'
      $packageCommonWeb             = 'icinga-web'
      $packageNrpe                  = 'nrpe'
      $packageApache                = 'httpd'
      $packageIdoMysql              = 'icinga2-ido-mysql'
      $packageIdoutilsMysql         = 'icinga-idoutils-libdbi-mysql'
      $packagePlugins               = 'nagios-plugins'
      $packagePluginsPerl           = 'nagios-plugins-perl'
      $packagePluginsAll            = 'nagios-plugins-all'
      $packagePhpCommon             = 'php'
      $packagePhpMysql              = 'php-mysql'
      $packagePhpLdap               = 'php-ldap'
      $packagePhpGd                 = 'php-gd'
      $packageNetSnmp               = 'net-snmp'
      $packageNetSnmpDevel          = 'net-snmp-devel'
      $packageNetSnmpUtils          = 'net-snmp-utils'
      $packageRrdTool               = 'rrdtool'
      $packageRrdToolPerl           = 'rrdtool-perl'
      $packagePnp4Nagios            = 'pnp4nagios'
      $packageIcingaWebPnp          = 'icinga-web-module-pnp'

      # Config definition
      $configIcingaConf             = '/etc/icinga/icinga.cfg'
      $configIcingaConfTemplate     = 'icinga/etc/icinga/icinga.cfg.erb'
      $configIdoDbConf              = '/etc/icinga/ido2db.cfg'
      $configIdoDbConfTemplate      = 'icinga/etc/icinga/ido2db.cfg.erb'
      $configIdoModConf             = '/etc/icinga/idomod.cfg'
      $configIdoModTemplate         = 'icinga/etc/icinga/idomod.cfg.erb'
      $configP4NConfig              = '/etc/pnp4nagios/config.php'
      $configP4NConfigTemplate      = 'icinga/etc/pnp4nagios/config.php.erb'
      $configP4NPerfdata            = '/etc/pnp4nagios/process_perfdata.cfg'
      $configP4NPerfdataTemplate    = 'icinga/etc/pnp4nagios/process_perfdata.cfg.erb'
      $configP4NHttp                = '/etc/httpd/conf.d/pnp4nagios.conf'
      $configP4NHttpTemplate        = 'icinga/etc/httpd/conf.d/pnp4nagios.conf.erb'
      $configNrpeConfig             = '/etc/nagios/nrpe.cfg'
      $configNrpeConfigTemplate     = 'icinga/etc/nagios/nrpe.cfg.erb'
      $configNrpeConfigBase         = '/etc/nrpe.d/base.cfg'
      $configNrpeConfigBaseTemplate = 'icinga/etc/nrpe.d/base.cfg.erb'
      $configSchemaScript           = '/etc/icinga/populate_icinga_schema.sh'
      $configSchemaScriptFile       = 'puppet:///modules/icinga/schema/populate_icinga_schema.sh'

      # Service definition
      $serviceCommon                = 'icinga2'
      $serviceNrpe                  = 'nrpe'
      $serviceApache                = 'httpd'
    }
    default  : {
      $linux                        = false
    }
  }

  # Icinga 2 definitions
  $client             = false
  $server             = false
  $plugins            = ['none']
  $exportedResources  = false
}
