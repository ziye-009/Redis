include:
  - modules.database.redis.install

salve-file:
  file.managed:
    - names:
      - /etc/redis.conf:
        - source: salt://modules/database/redis/files/redis-slave.conf.j2
        - template: jinja
      - /usr/lib/systemd/system/redis_server.service:
        - source: salt://modules/database/redis/files/redis_server.service

slave:
  service.running:
    - name: redis_server.service
    - enable: true
    - reload: true
    - watch:
      - file: provide-program-file







