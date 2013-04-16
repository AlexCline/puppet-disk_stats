# Class: disk_stats

# This class isn't required to use the disk_stats facts.  It will
# install the required sys-filesystem gem.

class disk_stats {
  exec { 'Install sys-filesystem rubygem':
    command => '/bin/env gem install sys-filesystem',
    unless  => '/bin/env gem list --local | /bin/grep sys-filesystem',
  }
}
