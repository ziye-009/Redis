

/etc/my.cnf.d/master.cnf:
  file.managed:
    - source: salt://modeles/database/mysql/files/master.cnf
    - user: root
    - group: root
    - mode: '0664'

master-service:
  service.running:
    - name: mysqld.service
    - enable: true
    - reload: true
    - watch:
      - file: /etc/my.cnf.d/master.cnf
