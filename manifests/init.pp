# Class: disk_stats

# This class isn't required to use the disk_stats facts.  It will
# install the required sys-filesystem gem.

# Note, this will install the gem after the first time the fact is
# executed.  This means if the gem isn't already installed, it will
# take two puppet runs for the facts to be correctly populated.

class disk_stats {
  if ! defined ( Package['rubygems'] )   { package { 'rubygems':   ensure => installed, } }

  case $::operatingsystem {
    'CentOS', 'RedHat': {
      if ! defined ( Package['ruby-devel'] ) { package { 'ruby-devel': ensure => installed, } }
      if ! defined ( Package['make'] )       { package { 'make':       ensure => installed, } }
      if ! defined ( Package['gcc-c++'] )    { package { 'gcc-c++':    ensure => installed, } }
      $require_list = [ Package['rubygems'], Package['ruby-devel'], Package['make'], Package['gcc-c++'], ]
    }
    default: {
      $require_list = [ Package['rubygems'], ]
    }
  }

  $env_path = $::operatingsystem ? {
    /^(CentOS|RedHat)$/ => '/bin/env',
    /^(Ubuntu|Debian)$/ => '/usr/bin/env',
  }

  exec { 'Install sys-filesystem rubygem dependency':
    command => "${env_path} gem install sys-filesystem",
    unless  => "${env_path} gem list --local | /bin/grep sys-filesystem",
    require => $require_list,
  }
}
