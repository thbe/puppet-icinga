# Class: icinga::config::mysql
#
# This class contain the configuration for Icinga MySQL databases
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include icinga::config::mysql
#
class icinga::config::mysql {
  # Setup mysql databases
  class { '::mysql::server':
    root_password    => '0nly4install',
    override_options => {
      'mysqld' => {
        'max_connections' => '1024'
        }
      },
    databases        => {
      'icinga'       => {
        ensure  => present,
        charset => 'utf8',
      },
      'icingaweb_db' => {
        ensure  => present,
        charset => 'utf8',
      },
    },
    grants           => {
      'icinga@localhost/icinga.*'             => {
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
    users            => {
      'icinga@localhost'       => {
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
    $icinga::params::config_icinga2_ido_mysql:
      ensure  => present,
      mode    => '0640',
      owner   => icinga,
      group   => icinga,
      path    => $icinga::params::config_icinga2_ido_mysql,
      content => template($icinga::params::config_icinga2_ido_mysql_template),
      require => Package[$icinga::params::package_icinga2_ido_mysql];

    $icinga::params::config_schema_script:
      ensure  => present,
      mode    => '0755',
      owner   => root,
      group   => root,
      path    => $icinga::params::config_schema_script,
      source  => $icinga::params::config_schema_script_file,
      require => Package[$icinga::params::package_icinga2_ido_mysql];
  }
}
