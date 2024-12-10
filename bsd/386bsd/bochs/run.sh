#!/usr/bin/env bash

set -euo pipefail

install_freebsd_2_2_9()
{
  [ -e boot.flp ] || wget http://ftp-archive.freebsd.org/pub/FreeBSD-Archive/old-releases/i386/2.2.9-RELEASE/floppies/boot.flp
  [ -e 2.2.9-RELEASE.iso] || wget http://ftp-archive.freebsd.org/pub/FreeBSD-Archive/old-releases/i386/ISO-IMAGES/2.2.9/2.2.9-RELEASE.iso

  qemu-img create -f raw freebsd.img 200M
  qemu-system-i386 -m 8M -fda ./boot.flp  -hda ./freebsd.img -cdrom ./2.2.9-RELEASE.iso -boot a
  qemu-system-i386 -m 8M -fda ./boot.flp  -hda ./freebsd.img -cdrom ./2.2.9-RELEASE.iso -boot c


  cat <<EOF
Execute the following commands on FreeBSD 2.2.9
mount /dev/wd1 /mnt
mount -t cd9660  /dev/wcd0a /cdrom
mkdir -p /mnt/work/cdrom
cd /mnt/work/cdrom
cp -r /cdrom/386bsd .
cd 386bsd/srcdist
cat src01* | uncompress | cpio -iadvm
sync
umount /cdrom
umount /mnt
shutdown now
EOF

  qemu-system-i386 -m 8M -fda ./boot.flp  -hda ./freebsd.img -hdb ./386bsd.img -cdrom ./386bsd_199208.iso
  -boot c

}

run()
{
  bochs -q -f bochsrc.386bsd  
}

run


