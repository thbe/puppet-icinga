# Define: icinga::config::object::command
#
# This define handle the command part of exported ressources
#
# Parameters:
#
# * `command_line`
#   Specify the command line
#
# * `command_name`
#   Specify the command name
#
# * `args`
#   Specify arguments
#
# * `vars`
#   Specify variables
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
define icinga::config::object::command (
  $command_line,
  $command_name   = $title,
  $args           = {},
  $vars           = {},
  $target         = '/etc/icinga2/conf.d/puppet/commands.conf',
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
      order   => '01'
    }
  }

  concat::fragment { "${target}_${name}":
    target  => $target,
    content => template('icinga2/object/command.erb'),
    order   => '02'
  }
}
