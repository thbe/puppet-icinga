# Define: icinga::config::object::host
#
# This define handle the host part of exported ressources
#
# Parameters:
#
# * `host_name`
#   Specify the host name
#
# * `address`
#   Specify IPv4 address
#
# * `address6`
#   Specify IPv6 address
#
# * `import`
#   Specify host template
#
# * `os`
#   Specify operating system
#
# * `sla`
#   Specify SLA
#
# * `target`
#   Specify target filename
#
# Actions:      This define has no actions
#
# Requires:     This define has no requirements
#
# Sample Usage: icinga::config::object::host
#
define icinga::config::object::host (
  $host_name = $title,
  $address   = false,
  $address6  = false,
  $import    = 'generic-host',
  $os        = $::kernel,
  $sla       = '24x7',
  $target    = "/etc/icinga2/conf.d/puppet/hosts/${name}.conf",
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
    content => template('icinga2/object/host.erb'),
    order   => '02',
  }
}
