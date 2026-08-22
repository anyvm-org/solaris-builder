

[![Build](https://github.com/anyvm-org/solaris-builder/actions/workflows/build.yml/badge.svg)](https://github.com/anyvm-org/solaris-builder/actions/workflows/build.yml)

Latest: v2.0.6


The image builder for `solaris`


All the supported releases are here:



| Release | Comments | x86_64 |
|---------|---------|---------|
| 11.4-gcc-14 | CBE with gcc/g++ 14 | ✅ (rsync,scp,nfs,tar) |
| 11.4-gcc | CBE with default gcc/g++ | ✅ (rsync,scp,nfs,tar) |
| 11.4-clang-19 | CBE with llvm/clang 19 | ✅ (rsync,scp,nfs,tar) |
| 11.4 | Normal CBE | ✅ (rsync,scp,nfs,tar) |

<!-- extra-column: Comments -->
<!-- extra-value: 11.4 Normal CBE -->
<!-- extra-value: 11.4-gcc CBE with default gcc/g++ -->
<!-- extra-value: 11.4-clang-19 CBE with llvm/clang 19 -->
<!-- extra-value: 11.4-gcc-14 CBE with gcc/g++ 14 -->

Built on Oracle Solaris 11.4 CBE 11.4.90.0.0.212.0

If you need native Sun stuido compiler, you need to download it here:

https://www.oracle.com/tools/developerstudio/downloads/developer-studio-jsp.html

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




How to build:

1. Use the [manual.yml](.github/workflows/manual.yml) to build manually.
   
    Run the workflow manually, you will get a view-only webconsole from the output of the workflow, just open the link in your web browser.
   
    You will also get an interactive VNC connection port from the output, you can connect to the vm by any vnc client.

2. Run the builder locally on your Ubuntu machine.

    Just clone the repo. and run:
    ```bash
    python3 build.py conf/solaris-11.4.conf
    ```
   
