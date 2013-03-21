# disk_stats.rb
# The disk_stats base facter fact.

require 'facter'

root_device = Facter::Util::Resolution.exec('/bin/readlink /dev/root')

Facter.add(:disk_stats_root_) do
  confine :kernel => "Linux"
  setcode do
    root_device
  end
end




#Facter.add(:disk_stats_root) do
#  confine :kernel => "Linux"
#  setcode do
#    Facter::Util::Resolution.exec('readlink /dev/root')
#  end
#end
