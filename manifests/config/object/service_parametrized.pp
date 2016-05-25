# Define: icinga::config::object::service_parametrized
#
# This define handle the host part of exported ressources
#
# This definition is a wrapper around icinga2::object::service.
# It allows definitions of services which need the name of the service
# as part of the check command, like filesystem and SMART checks.
#
# Parameters:
#
# * `check_command`
#   Specify the check command
#
# * `command`
#   Specify the command
#
# * `groups`
#   Specify the groups
#
# Actions:      This define has no actions
#
# Requires:     This define has no requirements
#
# Sample Usage: icinga::config::object::host
#
define icinga::config::object::service_parametrized(
  $check_command = false,
  $command       = false,
  $groups        = false
) {
  @@icinga::config::object::service { "${::fqdn}_${name}":
    service_name  => $name,
    host_name     => $::fqdn,
    check_command => $check_command,
    vars          => {
      nrpe_command => "${command}${name}"
      },
    groups        => $groups,
  }
}
