


sed 's/^PASSREQ=YES/PASSREQ=NO/' /etc/default/login > /tmp/login.new
cat /tmp/login.new >/etc/default/login
passwd -d root
rm -f /tmp/login.new


# Do not let first boot regenerate the man page index: application/man-index
# runs catman over all of /usr/share/man on EVERY boot of the shipped image
# (the index state never persists into the snapshot), peaking at ~560 MB RSS
# for ~50 s. With 2048 MB the kernel (~1 GB) plus catman exhausts RAM+swap
# before sshd starts ("Cannot allocate memory", "/tmp: File system full,
# swap space limit exceeded"), so the boot probe times out -- seen on
# vmactions/solaris-vm#63 and reproduced locally. The Solaris Web UI (four
# httpd processes) is useless in CI and goes too. Measured on the same host
# with -m 2048: 150 s+ timeout before, 26 s to ssh after.
svcadm disable application/man-index
svcadm disable system/webui/server

echo "Purging any stale OS snapshots..."
beadm list | tail +3 | while read -r line; do
  name=`echo $line | awk '{ print $1 };'`
  mountpoint=`echo $line | awk '{ print $3 };'`
  if [ "$mountpoint" = "-" ] ; then
    echo "Removing $name: beadm destroy -F $name"
    beadm destroy -F $name
  fi
done



