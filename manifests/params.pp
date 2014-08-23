# Class: icinga::params
#
# This module contain the parameters for Icinga
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
      $linux = true

      # Package definition
      $packageCommon           = 'icinga2'
      $packageCommonWeb        = 'icinga-web'
      $packageApache           = 'httpd'
      $packageIdoMysql         = 'icinga2-ido-mysql'
      $packageIdoutilsMysql    = 'icinga-idoutils-libdbi-mysql'
      $packagePlugins          = 'nagios-plugins'
      $packagePluginsAll       = 'nagios-plugins-all'

      # Config definition
      $configIdoDbConf         = '/etc/icinga/ido2db.cfg'
      $configIdoDbConfTemplate = 'icinga/etc/ido2db.cfg.erb'
      $configIdoModConf        = '/etc/icinga/idomod.cfg'
      $configIdoModTemplate    = 'icinga/etc/idomod.cfg.erb'
      $configSchemaScript      = '/etc/icinga/populate_icinga_schema.sh'
      $configSchemaScriptFile  = 'puppet:///modules/icinga/schema/populate_icinga_schema.sh'

      # Service definition
      $serviceCommon           = 'icinga2'
      $serviceApache           = 'httpd'
    }
    default  : {
      $linux = false
    }
  }

  # Icinga 2 definitions
  $plugins = ['all']
}
