# define: icinga::config::object::service_generated
#
# This definition creates a icinga2::object::service from a hash,
# which is typically received from a YAML via hiera.
# It should not be used directly. Use icinga2::objects::service instead.

define icinga::config::object::service_generated($config){
  @@icinga::config::object::service { "${::fqdn}_${name}":
    service_name  => $config[$name]['service_name'],
    host_name     => $::fqdn,
    check_command => $config[$name]['check_command'],
    vars          => $config[$name]['vars'],
  }
}
