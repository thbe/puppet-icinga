require 'spec_helper'

describe 'icinga', :type => :class do

  context 'with defaults for all parameters' do
    it { should contain_class('icinga') }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:params) {
        {
          :type => 'server',
          :server_acl => '192.168.1.20',
          :exported_resources => false
        }
      }

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('icinga::params') }
      it { is_expected.to contain_class('icinga::package') }
      it { is_expected.to contain_class('icinga::package::client') }
      it { is_expected.to contain_class('icinga::package::server') }
      it { is_expected.to contain_class('icinga::config') }
      it { is_expected.to contain_class('icinga::config::client') }
      it { is_expected.to contain_class('icinga::config::mysql') }
      it { is_expected.to contain_class('icinga::config::server') }
      it { is_expected.to contain_class('icinga::service') }
      it { is_expected.to contain_class('icinga::service::client') }
      it { is_expected.to contain_class('icinga::service::server') }

      it { is_expected.to contain_class('mysql::server') }
      it { is_expected.to contain_class('mysql::server::backup') }
      it { is_expected.to contain_class('mysql::server::account_security') }
      it { is_expected.to contain_class('mysql::server::mysqltuner') }

      it { is_expected.to contain_package('nrpe').with_ensure('installed') }
      it { is_expected.to contain_package('nagios-plugins').with_ensure('installed') }
      it { is_expected.to contain_package('nagios-plugins-perl').with_ensure('installed') }
      it { is_expected.to contain_package('nagios-plugins-all').with_ensure('installed') }

      it { is_expected.to contain_package('icinga2').with_ensure('installed') }
      it { is_expected.to contain_package('icingacli').with_ensure('installed') }
      it { is_expected.to contain_package('icingaweb2').with_ensure('installed') }
      it { is_expected.to contain_package('icinga2-ido-mysql').with_ensure('installed') }

      it { is_expected.to contain_package('httpd').with_ensure('installed') }
      it { is_expected.to contain_package('net-snmp-devel').with_ensure('installed') }
      it { is_expected.to contain_package('net-snmp-utils').with_ensure('installed') }
      it { is_expected.to contain_package('net-snmp').with_ensure('installed') }
      it { is_expected.to contain_package('php-gd').with_ensure('installed') }
      it { is_expected.to contain_package('php-ldap').with_ensure('installed') }
      it { is_expected.to contain_package('php-mysql').with_ensure('installed') }
      it { is_expected.to contain_package('php').with_ensure('installed') }
      it { is_expected.to contain_package('rrdtool-perl').with_ensure('installed') }
      it { is_expected.to contain_package('rrdtool').with_ensure('installed') }

      it { is_expected.to contain_file('/etc/icinga2/conf.d/custom').with_ensure('directory') }
      it { is_expected.to contain_file('/etc/icinga2/conf.d/puppet').with_ensure('directory') }

      it { is_expected.to contain_file('/etc/nagios/nrpe.cfg').with_ensure('file') }
      it { is_expected.to contain_file('/etc/nrpe.d/base.cfg').with_ensure('file') }
      it { is_expected.to contain_file('/etc/icinga2/features-available/ido-mysql.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/icinga2/populate_icinga_schema.sh').with_ensure('file') }

      it { is_expected.to contain_file('/etc/icinga2/features-enabled/checker.conf').with_ensure('link') }
      it { is_expected.to contain_file('/etc/icinga2/features-enabled/command.conf').with_ensure('link') }
      it { is_expected.to contain_file('/etc/icinga2/features-enabled/graphite.conf').with_ensure('link') }
      it { is_expected.to contain_file('/etc/icinga2/features-enabled/ido-mysql.conf').with_ensure('link') }
      it { is_expected.to contain_file('/etc/icinga2/features-enabled/mainlog.conf').with_ensure('link') }
      it { is_expected.to contain_file('/etc/icinga2/features-enabled/notification.conf').with_ensure('link') }
      it { is_expected.to contain_file('/etc/icinga2/features-enabled/syslog.conf').with_ensure('link') }

      it { is_expected.to contain_file('/etc/icingaweb2/enabledModules').with_ensure('directory') }

      it { is_expected.to contain_file('/etc/icingaweb2/enabledModules/doc').with_ensure('link') }
      it { is_expected.to contain_file('/etc/icingaweb2/enabledModules/monitoring').with_ensure('link') }

      it 'should generate valid content for nrpe.cfg - generic part' do
        content = catalogue.resource('file', '/etc/nagios/nrpe.cfg').send(:parameters)[:content]
        expect(content).to match('allowed_hosts=192.168.1.20')
      end

      it 'should generate valid content for base.cfg - generic part' do
        content = catalogue.resource('file', '/etc/nrpe.d/base.cfg').send(:parameters)[:content]
        expect(content).to match('/usr/lib64/nagios/plugins/check_ssh')
      end

      it { is_expected.to contain_service('nrpe').with( 'ensure' => 'running', 'enable' => 'true') }
      it { is_expected.to contain_service('icinga2').with( 'ensure' => 'running', 'enable' => 'true') }
      it { is_expected.to contain_service('httpd').with( 'ensure' => 'running', 'enable' => 'true') }

      it { is_expected.to contain_exec('/etc/icinga/populate_icinga_schema.sh').with(
        'path'   => '/bin:/sbin:/usr/bin:/usr/sbin',
        'onlyif' => 'test -x /etc/icinga/populate_icinga_schema.sh',
        'unless' => 'test -f /etc/sysconfig/mysqldb_icinga && test -f /etc/sysconfig/mysqldb_icinga_web'
        )
      }

      it { is_expected.to contain_mysql_database('icinga') }
      it { is_expected.to contain_mysql_database('icingaweb_db') }
      it { is_expected.to contain_mysql_grant('icinga@localhost/icinga.*') }
      it { is_expected.to contain_mysql_grant('icingaweb_db@localhost/icingaweb_db.*') }
      it { is_expected.to contain_mysql_user('icinga@localhost') }
      it { is_expected.to contain_mysql_user('icingaweb_db@localhost') }

      case facts[:operatingsystem]
      when 'RedHat'
      when 'OracleLinux'
      when 'CentOS'
      when 'Scientific'
      end

      case facts[:osfamily]
      when 'RedHat'
        if facts[:operatingsystemmajrelease] != '7'
          it { is_expected.to contain_warning('The current operating system is not supported!') }
        end
      else
        it { is_expected.to contain_warning('The current operating system is not supported!') }
      end
    end
  end
end
