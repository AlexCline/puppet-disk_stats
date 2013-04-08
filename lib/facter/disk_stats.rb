# disk_stats.rb
# The disk_stats fact.

require 'facter'
require 'rubygems'


if Gem.available? 'sys-filesystem'
  require 'sys/filesystem'
  
  Sys::Filesystem.mounts.each do |m|

    # Don't print binfmt or tmpfs partitions
    if m.mount_type.match(/(binfmt|tmpfs)/)
      next
    end

    label = m.mount_point == '/' ? '_root' : m.mount_point.gsub('/', '_')
    stats = Sys::Filesystem.stat(m.mount_point)

    Facter.add("disk_stats#{label}_type") do
      setcode { m.mount_type }
    end

    Facter.add("disk_stats#{label}_size") do
      setcode { blocks_to_bytes( stats.block_size, stats.blocks ) }
    end

    Facter.add("disk_stats#{label}_free") do
      setcode { blocks_to_bytes( stats.block_size, stats.blocks_available ) }
    end

    Facter.add("disk_stats#{label}_used") do
      setcode { blocks_to_bytes( stats.block_size, ( stats.blocks - stats.blocks_available ) ) }
    end

    Facter.add("disk_stats#{label}_options") do
      setcode { m.options }
    end

  end

else

  # If the sys-filesystem gem is missing, return a useful message.
  Facter.add(:disk_stats) do
    setcode { "Required rubygem 'sys-filesystem' not installed." }
  end

end

# Convert block_size and quantity to a human-readable disk size.
def blocks_to_bytes(block_size, qty)
  size = ( block_size / 1024 ) * qty
  if size < 1000
    output = "#{size} KB"
  elsif size < 1000000
    output = "#{size / 1000} MB"
  elsif size < 1000000000
    output = "#{size / 1000000} GB"
  else
    output = "#{size / 1000000000} TB"
  end

  return output
end
