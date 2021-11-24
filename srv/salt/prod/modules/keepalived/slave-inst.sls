install-keeplived:
  pkg.installed:
    - name: keepalived


copu-keepalived.conf:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://modules/keepalived/files/slave-keep.conf

create-shell:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: true
    - name: /scripts

copu-shell:
  file.managed:
    - source: salt://modules/keepalived/files/notify.sh
    - name: /scripts/notify.sh
    - mode: '0755'


service-keepalived:
  service.running:
    - name: keepalived

