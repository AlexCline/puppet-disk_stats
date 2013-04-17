disk_stats
=======
*A Puppet module containing a set of facts about system disk stats and usage.*

Examples
------
Facts are created for each mounted partition in the system.  The name of the fact is generated from the mount path of the partition.


    disk_stats_root_free => 18 GB
    disk_stats_root_options => rw,errors=remount-ro
    disk_stats_root_path => /
    disk_stats_root_size => 20 GB
    disk_stats_root_type => ext4
    disk_stats_root_used => 2 GB


_Note: Swap and [binfmt](http://en.wikipedia.org/wiki/Binfmt_misc) partitions and devices with 0 blocks are not shown._


Installation
------

The disk_stats module requires the 'sys/filesystem' ruby gem.  You can install it using:

    gem install sys-filesystem

Or, you can include the 'disk_stats' class on your nodes.

    include disk_stats


Support
-------

Please file tickets and issues using [GitHub Issues](https://github.com/AlexCline/disk_stats/issues)


License
-------
   Copyright 2013 Alex Cline <alex.cline@gmail.com>

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
