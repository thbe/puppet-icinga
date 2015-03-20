# Class: icinga::repository
#
# This class contain the repository configuration for Icinga
#
# Parameters:   This class has no parameters
#
class icinga::repository {
  # Install Icinga repository
  class { '::yum': repoIcinga => true }
}
