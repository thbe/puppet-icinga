# Define: icinga::config::object::service_generated
#
# This define handle the generated service part of exported ressources
#
# This definition creates a icinga::object::service from a hash,
# which is typically received from a YAML via hiera.
# It should not be used directly. Use icinga::objects::service instead.
#
# Parameters:
#
# * `config`
#   Specify the hash
#
# Actions:      This define has no actions
#
# Requires:     This define has no requirements
#
# Sample Usage: icinga::config::object::service_generated
#
define icinga::config::object::service_generated(
  $config
){
  @@icinga::config::object::service { "${::fqdn}_${name}":
    service_name  => $config[$name]['service_name'],
    host_name     => $::fqdn,
    check_command => $config[$name]['check_command'],
    vars          => $config[$name]['vars'],
  }
}
