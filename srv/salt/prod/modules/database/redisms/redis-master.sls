include:
  - modules.database.redis.install

master-file:
  file.managed:
      - /etc/redis.conf:
        - source: salt://modules/database/redis/files/redis.conf.j2
        - template: jinja
      - /usr/lib/systemd/system/redis_server.service:
        - source: salt://modules/database/redis/files/redis_server.service

master-server:
  service.running:
    - name: redis_server.service
    - enable: true
    - reload: true
    - watch:
      - file: provide-program-file







