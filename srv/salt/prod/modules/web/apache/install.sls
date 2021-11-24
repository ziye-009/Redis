"Development Tools":
  pkg.group_installed




httpd-dep-package:
  pkg.installed:
    - pkgs:
      - openssl-devel
      - pcre-devel
      - expat-devel
      - libtool
      - gcc
      - gcc-c++
      - make



create-apache-user:
  user.present:
    - name: apache
    - createhome: false
    - system: true
    - shell: /sbin/nologin


download-apache:
  file.managed:
    - names:
      - /usr/src/apr-1.7.0.tar.gz:
        - source: salt://modules/web/apache/file/apr-1.7.0.tar.gz
      - /usr/src/apr-util-1.6.1.tar.gz:
        - source: salt://modules/web/apache/file/apr-util-1.6.1.tar.gz
      - /usr/src/httpd-2.4.48.tar.gz:
        - source: salt://modules/web/apache/file/httpd-2.4.48.tar.gz
    



salt://modules/web/apache/file/install.sh:
  cmd.script

/usr/local/httpd/conf/httpd.conf:
  file.managed:
    - source: salt://modules/web/apache/file/httpd.conf
    - user: root
    - group: root
    - mode: '0644'




/usr/lib/systemd/system/httpd.service:
  file.managed:
    - source: salt://modules/web/apache/file/httpd.service




