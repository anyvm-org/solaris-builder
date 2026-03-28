


sed 's/^PASSREQ=YES/PASSREQ=NO/' /etc/default/login > /tmp/login.new
cat /tmp/login.new >/etc/default/login
passwd -d root
rm -f /tmp/login.new


echo "Purging any stale OS snapshots..."
beadm list | tail +3 | while read -r line; do
  name=`echo $line | awk '{ print $1 };'`
  mountpoint=`echo $line | awk '{ print $3 };'`
  if [ "$mountpoint" = "-" ] ; then
    echo "Removing $name: beadm destroy -F $name"
    beadm destroy -F $name
  fi
done


# Zero unused disk space on ZFS filesystems that have had activity.
# Solaris 11 uses ZFS, so we zero on each ZFS mountpoint.
for fs in / /usr /var /tmp; do
  # Check if this path is a ZFS mountpoint
  if zfs list -H -o mountpoint 2>/dev/null | grep -qx "$fs"; then
    echo zeroing unused space on $fs
    dd if=/dev/zero of=$fs/zero bs=1024k >/dev/null 2>&1 || true
    sync
    rm -f $fs/zero
  fi
done

# Clear swap space
# Solaris 11 uses 'swap -l' to list swap devices/files
swap=$(swap -l 2>/dev/null | awk 'NR>1 {print $1}')
if [ ! -z "$swap" ]; then
  for s in $swap; do
    echo zeroing swap $s
    swap -d $s
    # Only dd to block devices, not swap files on ZFS zvols
    case "$s" in
      /dev/zvol/dsk/* | /dev/dsk/*)
        dd if=/dev/zero of=$s bs=1024k >/dev/null 2>&1 || true
        ;;
    esac
    swap -a $s
  done
fi

