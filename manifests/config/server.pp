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
      'icinga_web' => {
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
      'icinga_web@localhost/icinga_web.*' => {
        ensure     => present,
        options    => [ 'GRANT' ],
        privileges => [ 'CREATE', 'CREATE VIEW', 'INDEX', 'SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'EXECUTE' ],
        table      => 'icinga_web.*',
        user       => 'icinga_web@localhost',
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
      'icinga_web@localhost' => {
        ensure                   => 'present',
        max_connections_per_hour => '0',
        max_queries_per_hour     => '0',
        max_updates_per_hour     => '0',
        max_user_connections     => '0',
        password_hash            => '*B653CD49D5A5CECE83D6A9DCF28B32DC06F9830F',
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
    $icinga::params::configIcingaConf:
      ensure  => present,
      mode    => '0664',
      owner   => root,
      group   => root,
      path    => $icinga::params::configIcingaConf,
      content => template($icinga::params::configIcingaConfTemplate),
      require => Package[$icinga::params::packageCommon];

    $icinga::params::configIdoDbConf:
      ensure  => present,
      mode    => '0660',
      owner   => root,
      group   => root,
      path    => $icinga::params::configIdoDbConf,
      content => template($icinga::params::configIdoDbConfTemplate),
      require => Package[$icinga::params::packageIdoutilsMysql];

    $icinga::params::configIdoModConf:
      ensure  => present,
      mode    => '0664',
      owner   => root,
      group   => root,
      path    => $icinga::params::configIdoModConf,
      content => template($icinga::params::configIdoModTemplate),
      require => Package[$icinga::params::packageIdoutilsMysql];

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
    # to be done
  }

  # Setup password file for pnp4nagios
  exec { '/usr/bin/htpasswd -bc /etc/icinga/passwd root password':
    path   => '/bin:/sbin:/usr/bin:/usr/sbin',
    unless => 'test -f /etc/icinga/passwd'
  }
}
