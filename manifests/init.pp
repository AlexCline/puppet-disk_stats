# Class: disk_stats

# This class isn't required to use the disk_stats facts.  It will
# install the required sys-filesystem gem.

# Note, this will install the gem after the first time the fact is
# executed.  This means if the gem isn't already installed, it will
# take two puppet runs for the facts to be correctly populated.

class disk_stats {
  exec { 'Install sys-filesystem rubygem':
    command => '/bin/env gem install sys-filesystem',
    unless  => '/bin/env gem list --local | /bin/grep sys-filesystem',
  }
}
