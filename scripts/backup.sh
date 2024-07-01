# SPDX-License-Identifier: CC0-1.0
su -c "cd $HOME; \
       tar --exclude-from=$XDG_CONFIG_HOME/scripts/exclude --exclude=$HOME/bp.tar \
           --acls --xattrs -pvcf bp.tar /; \
       xz -T0 -9 --memlimit=16GB $HOME/bp.tar"
