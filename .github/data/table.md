

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

Upstream install media: the official Oracle Solaris 11.4 text installer
ISO (download page:
https://www.oracle.com/solaris/solaris11/downloads/solaris-downloads.html).
