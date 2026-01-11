

[![Build](https://github.com/anyvm-org/solaris-builder/actions/workflows/build.yml/badge.svg)](https://github.com/anyvm-org/solaris-builder/actions/workflows/build.yml)

Latest: v2.0.4


The image builder for `solaris`


All the supported releases are here:



| Release | x86_64  |  Comments |
|---------|---------|-----------|
| 11.4    |  ✅     | Normal CBE |
| 11.4-gcc|  ✅     | CBE with default gcc/g++|
| 11.4-clang-19|  ✅     | CBE with llvm/clang 19 |
| 11.4-gcc-14|  ✅     | CBE with gcc/g++ 14 |

If you need native Sun stuido compiler, you need to download it here:

https://www.oracle.com/tools/developerstudio/downloads/developer-studio-jsp.html








How to build:

1. Use the [manual.yml](.github/workflows/manual.yml) to build manually.
   
    Run the workflow manually, you will get a view-only webconsole from the output of the workflow, just open the link in your web browser.
   
    You will also get an interactive VNC connection port from the output, you can connect to the vm by any vnc client.

2. Run the builder locally on your Ubuntu machine.

    Just clone the repo. and run:
    ```bash
    bash build.sh conf/solaris-11.4.conf
    ```
   
