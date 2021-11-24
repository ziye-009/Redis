include:
  - init.yum.main

install-base-packages:
  pkg.installed:
    - pkgs:
      - screen
      - tree
      - psmisc
      - openssl
      - openssl-devel
      - telnet
      - iftop
      - iotop
      - sysstat
      - wget
      - dos2unix
      - unix2dos
      - lsof
      - net-tools
      - vim-enhanced
      - zip
      - unzip
      - bzip2
      - bind-utils
      - gcc
      - gcc-c++
      - glibc
      - make
      - autocnf

