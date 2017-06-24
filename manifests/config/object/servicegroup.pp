# Define: icinga::config::object::servicegroup
#
# This define handle the host part of exported ressources
#
# Parameters:
#
# * `servicegroup_name`
#   Specify the service group name
#
# * `display_name`
#   Specify the display name
#
# * `groups`
#   Specify the groups
#
# * `target`
#   Specify target filename
#
# Actions:      This define has no actions
#
# Requires:     This define has no requirements
#
# Sample Usage: icinga::config::object::servicegroup
#
define icinga::config::object::servicegroup (
  $servicegroup_name = $title,
  $display_name      = $title,
  $groups            = false,
  $target            = '/etc/icinga2/conf.d/puppet/servicegroups.conf',
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
    content => template('icinga2/object/servicegroup.erb'),
    order   => '02',
  }
}
