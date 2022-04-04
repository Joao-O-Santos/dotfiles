# SPDX-License-Identifier: CC0-1.0
su -c "cd $HOME; tar --exclude-from=exclude --acls --xattrs -pvcf bp.tar /"
xz -T0 -9 $HOME/bp.tar
