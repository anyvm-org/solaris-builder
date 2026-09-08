


sed 's/^PASSREQ=YES/PASSREQ=NO/' /etc/default/login > /tmp/login.new
cat /tmp/login.new >/etc/default/login
passwd -d root
rm -f /tmp/login.new


# Trim services a CI guest never needs. The image is booted from a fresh
# snapshot on every run, so anything that reruns at boot is paid on every
# job. Measured on the shipped 2.0.7 image (4 GB, ~60 s after boot):
#   application/man-index   catman over all of /usr/share/man on EVERY boot
#                           (the index never persists), 564 MB RSS peak, ~50 s.
#                           With 2048 MB the kernel (~1 GB) plus catman
#                           exhausts RAM+swap before sshd starts ("Cannot
#                           allocate memory", "/tmp: File system full, swap
#                           space limit exceeded") -- vmactions/solaris-vm#63.
#   system/sstore           sstored 133 MB (+ sysstat 15 MB, telemetry-manager)
#   system/webui/server     5 httpd + 2 rotatelogs, 56 MB, listens on 6787
#   hal/dbus/rmvolmgr       removable-media stack, 20 MB, nothing depends on it
#   fm/asr-notify, fm/smtp-notify   Oracle ASR / mail fault notification, 12 MB
#   console-login:vt2..vt6, vtdaemon   virtual terminals, 5 ttymon, ~10 MB
#   smb, smb/client2, ib-management, fcoe_initiator, iscsi/initiator,
#   sendmail-client, security/compliance:generate-guide   unused, ~15 MB
# Kept on purpose: rad:local (milestone/single-user depends on it), fmd
# (devchassis/coremon depend on it), auditd, picl, zones, nfs/*, autofs.
# Verified on the same host with -m 2048 and the production -cpu flags:
# boot-to-ssh 150 s+ timeout before, 25.6 s after; svcs -x clean; resident
# process RSS 587 MB -> 317 MB.
for s in \
    application/man-index \
    system/webui/server \
    system/sstore \
    system/sysstat \
    system/install/telemetry-manager:stats \
    system/install/telemetry-manager:files \
    system/fm/asr-notify \
    system/fm/smtp-notify \
    system/filesystem/rmvolmgr \
    system/hal \
    system/dbus \
    network/smb/client2 \
    network/smb \
    system/fcoe_initiator \
    network/iscsi/initiator \
    network/ib/ib-management \
    network/sendmail-client \
    system/console-login:vt2 \
    system/console-login:vt3 \
    system/console-login:vt4 \
    system/console-login:vt5 \
    system/console-login:vt6 \
    system/vtdaemon \
    application/security/compliance:generate-guide ; do
  svcadm disable "$s" || echo "WARNING: svcadm disable $s failed"
done

echo "Purging any stale OS snapshots..."
beadm list | tail +3 | while read -r line; do
  name=`echo $line | awk '{ print $1 };'`
  mountpoint=`echo $line | awk '{ print $3 };'`
  if [ "$mountpoint" = "-" ] ; then
    echo "Removing $name: beadm destroy -F $name"
    beadm destroy -F $name
  fi
done



