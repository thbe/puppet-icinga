# Class: icinga::install
#
# This class contain the installation for Icinga
#
# Parameters:   This class has no parameters
#
# Actions:      This class has no actions
#
# Requires:     This class has no requirements
#
# Sample Usage: include icinga::install
#
class icinga::install {

  if $icinga::type == 'client' {
    include ::icinga::install::client
  }

  if $icinga::type == 'server' {
    include ::icinga::install::client
    include ::icinga::install::server
  }
}
