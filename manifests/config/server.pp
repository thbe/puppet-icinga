# Class: icinga::config::server
#
# This class contain the configuration for Icinga
#
# Parameters: This class has no parameters
#
class icinga::config::server {

  # Setup mysql databases
  class { '::mysql::server':
    root_password    => '0nly4install',
    override_options => { 'mysqld' => { 'max_connections' => '1024' } },
    databases => {
      'icinga' => {
        ensure  => present,
        charset => 'utf8',
      },
      'icingaweb_db' => {
        ensure  => present,
        charset => 'utf8',
      },
    },
    grants => {
      'icinga@localhost/icinga.*' => {
        ensure     => present,
        options    => [ 'GRANT' ],
        privileges => [ 'CREATE', 'CREATE VIEW', 'INDEX', 'SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'EXECUTE' ],
        table      => 'icinga.*',
        user       => 'icinga@localhost',
      },
      'icingaweb_db@localhost/icingaweb_db.*' => {
        ensure     => present,
        options    => [ 'GRANT' ],
        privileges => [ 'CREATE', 'CREATE VIEW', 'INDEX', 'SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'EXECUTE' ],
        table      => 'icingaweb_db.*',
        user       => 'icingaweb_db@localhost',
      },
    },
    users => {
      'icinga@localhost' => {
        ensure                   => 'present',
        max_connections_per_hour => '0',
        max_queries_per_hour     => '0',
        max_updates_per_hour     => '0',
        max_user_connections     => '0',
        password_hash            => '*F7EA22C777E1A8D2E1F61A2F9EBBD74FF489FF63',
      },
      'icingaweb_db@localhost' => {
        ensure                   => 'present',
        max_connections_per_hour => '0',
        max_queries_per_hour     => '0',
        max_updates_per_hour     => '0',
        max_user_connections     => '0',
        password_hash            => '*A59B3BA4A8D3C199B42C671AD1D4B8E7AD50A325',
      },
    },
  }

  class { '::mysql::server::backup':
    backupdir      => '/srv/mysql',
    backuppassword => '0nly4install',
    backupuser     => 'bckadm',
  }

  include mysql::server::account_security
  include mysql::server::mysqltuner

  exec { '/etc/icinga/populate_icinga_schema.sh':
    path   => '/bin:/sbin:/usr/bin:/usr/sbin',
    onlyif => 'test -x /etc/icinga/populate_icinga_schema.sh',
    unless => 'test -f /etc/sysconfig/mysqldb_icinga && test -f /etc/sysconfig/mysqldb_icinga_web'
  }

  # Setup Icinga server
  file {
    $icinga::params::configIcinga2IdoMysql:
      ensure  => present,
      mode    => '0660',
      owner   => root,
      group   => root,
      path    => $icinga::params::configIcinga2IdoMysql,
      content => template($icinga::params::configIcinga2IdoMysqlTemplate),
      require => Package[$icinga::params::packageIdoMysql];

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

    $icinga::params::configP4NConfig:
      ensure  => present,
      mode    => '0644',
      owner   => root,
      group   => root,
      path    => $icinga::params::configP4NConfig,
      content => template($icinga::params::configP4NConfigTemplate),
      require => Package[$icinga::params::packagePnp4Nagios];

    $icinga::params::configP4NPerfdata:
      ensure  => present,
      mode    => '0640',
      owner   => root,
      group   => root,
      path    => $icinga::params::configP4NPerfdata,
      content => template($icinga::params::configP4NPerfdataTemplate),
      require => Package[$icinga::params::packagePnp4Nagios];

    $icinga::params::configP4NHttp:
      ensure  => present,
      mode    => '0644',
      owner   => root,
      group   => root,
      path    => $icinga::params::configP4NHttp,
      content => template($icinga::params::configP4NHttpTemplate),
      require => Package[$icinga::params::packageApache];

    $icinga::params::configSchemaScript:
      ensure  => present,
      mode    => '0755',
      owner   => root,
      group   => root,
      path    => $icinga::params::configSchemaScript,
      source  => $icinga::params::configSchemaScriptFile,
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

  # Setup password file for pnp4nagios
  exec { '/usr/bin/htpasswd -bc /etc/icinga/passwd root password':
    path   => '/bin:/sbin:/usr/bin:/usr/sbin',
    unless => 'test -f /etc/icinga/passwd'
  }
}
