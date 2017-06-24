# Define: icinga::config::object::dependency
#
# This define handle the dependency part of exported ressources
#
# Parameters:
#
# * `parent_host_name`
#   Specify the parent host name
#
# * `dependency_name`
#   Specify the dependency name
#
# * `parent_service_name`
#   Specify parent service name
#
# * `child_host_name`
#   Specify the child host name
#
# * `child_service_name`
#   Specify the parent child service name
#
# * `disable_checks`
#   Disable checks
#
# * `disable_notifications`
#   Disable notifications
#
# * `period`
#   Specify the period
#
# * `states`
#   Specify states
#
# * `target`
#   Specify target filename
#
# Actions:      This define has no actions
#
# Requires:     This define has no requirements
#
# Sample Usage: icinga::config::object::dependency
#
define icinga::config::object::dependency (
  $parent_host_name,
  $dependency_name       = $title,
  $parent_service_name   = false,
  $child_host_name       = false,
  $child_service_name    = false,
  $disable_checks        = false,
  $disable_notifications = true,
  $period                = false,
  $states                = false,
  $target                = '/etc/icinga2/conf.d/puppet/dependencies.conf',
  ) {

  if ! defined(Concat[$target]) {
    concat { $target:
      ensure         => present,
      ensure_newline => true,
    }
  }

  if ! defined(Concat::Fragment["${target}_header"]) {
    concat::fragment { "${target}_header":
      target  => $target,
      content => '# THIS FILE IS MANAGED BY PUPPET',
      order   => '01',
    }
  }

  concat::fragment { "${target}_${name}":
    target  => $target,
    content => template('icinga2/object/dependency.erb'),
    order   => '02',
  }
}
