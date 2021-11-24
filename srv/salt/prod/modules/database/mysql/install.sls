dep-mysql-install:
  pkg.installed:
    - pkgs:
      - ncureses-compat-libs

mysql:
  user.present:
    - system: true
    - createhome: false
    - shell: /sbin/nologin

/usr/local:
  archive.extracted:
    - source: salt://modules/database/mysql/files/mysql-5.7.34-linux-glibc2.12-x86_64.tar.gz
  file.symlink:
    - name: /usr/local/mysql
    - target: /usr/local/mysql-5.7.34-linux-glibc2.12-x86_64

/usr/local/mysql:
  file.directory:
    - user: mysql
    - group: mysql
    - mode: '0755'
    - recurse:
      - user
      - group

/etc/profile.d/mysqld.sh:
  file.managed:
    - source: salt://modules/database/mysql/files/mysqld.sh
    - user: root
    - group: root
    - mode: '0644'

/opt/data:
  file.directory:
    - user: mysql
    - group: mysql
    - mode: '0755'
    - makedirs: true
    - recurse:
      - user
      - group

/etc/my.cnf.d:
  file.directory:
    - user: root
    - group: root
    - mode: '0644'
    - makedirs: true
    - recurse:
      - user
      - group

/etc/my.cnf:
  file.managed:
    - source: salt://modeles/database/mysql/files/my.cnf.j2
    - user: root
    - template: jinja
    - group: root
    - mode: '0664'

/usr/local//mysql/support-files/mysql.server:
  file.managed:
    - source: salt://modules/database/mysql/files/mysql.server
    - user: mysql
    - group: mysql
    - mode: '0755'

/usr/lib/systemd/system/mysqld.service:
  file.managed:
    - source: salt://modules/database/mysql/files/mysqld.service
    - user: root
    - group: root
    - mode: '0644'

mysql-initialize:
  cmd.run:
    - name: '/usr/local/mysql/bin/mysqld --initialize-insecure --user=mysql --datadir=/opt/data/'
    - require:
      - archive: /usr/local
      - user: mysql
      - file: /opt/data
    - unless: test  $(ls -l /opt/data |wc -l) -gt 1

mysqld.service:
  service.running:
    - enable: true
    - reload: true
    - watch:
      - file: /etc/my.cnf 
