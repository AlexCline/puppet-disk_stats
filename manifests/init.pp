# Class: disk_stats

# This class isn't required to use the disk_stats facts.  It will
# install the required sys-filesystem gem.

# Note, this will install the gem after the first time the fact is
# executed.  This means if the gem isn't already installed, it will
# take two puppet runs for the facts to be correctly populated.

class disk_stats {
  if ! defined ( Package['ruby-devel'] ) { package { 'ruby-devel': ensure => installed, } }
  if ! defined ( Package['make'] )       { package { 'make':       ensure => installed, } }
  if ! defined ( Package['gcc-c++'] )    { package { 'gcc-c++':    ensure => installed, } }

  exec { 'Install sys-filesystem rubygem dependency':
    command => '/bin/env gem install sys-filesystem',
    unless  => '/bin/env gem list --local | /bin/grep sys-filesystem',
    require => [ Package['ruby-devel'], Package['make'], Package['gcc-c++'], ],
  }
}
