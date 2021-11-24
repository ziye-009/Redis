install-keeplived:
  pkg.installed:
    - name: keepalived

copu-keepalived.conf:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://modules/keepalived/files/master-keep.conf

create-shell:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: true
    - name: /scripts

copy-shell:
  file.managed:
    - source: salt://modules/keepalived/files/check_h.sh
    - name: /scripts/check_h.sh
    - mode: '0755'



service-keepalived:
  service.running:
    - name: keepalived

