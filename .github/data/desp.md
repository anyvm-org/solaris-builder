How the images are built:

Each image is built automatically in the
[anyvm-org/solaris-builder](https://github.com/anyvm-org/solaris-builder)
repo's GitHub Actions: it boots the official Oracle Solaris 11.4 text
installer ISO in QEMU, answers the installer unattended, enables ssh,
pre-installs the packages listed in the conf, and exports the installed
disk as a compressed qcow2 image.

Upstream install media: the Oracle Solaris 11.4 text installer ISO from
Oracle's official download page
https://www.oracle.com/solaris/solaris11/downloads/solaris-downloads.html
(the download requires an Oracle account, so the CI fetches the same ISO
from the mirror at https://github.com/anyvm-org/solaris-download).
