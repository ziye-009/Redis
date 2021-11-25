include:
  - modules.haproxy.rsyslog

dep-haproxy-pkg:
  pkg.installed:
    - pkgs:
      - make
      - gcc 
      - pcre-devel 
      - bzip2-devel 
      - openssl-devel 
      - systemd-devel

haproxy:
  user.present:
    - system: true
    - createhome: false
    - shell: /sbin/nologin

unzip-haproxy:
  archive.extracted:
    - name: /usr/src
    - source: salt://modules/haproxy/files/haproxy-{{ pillar['haproxy_version'] }}.tar.gz

salt://modules/haproxy/files/install.sh.j2:
  cmd.script:
    - temolate: jinja
    - require:
      - archive: unzip-haproxy
    - unless: test -d {{ pillar['haproxy-install-dir'] }}

/usr/bin/haproxy:
  file.symlink:
    - target: {{ pillar['haproxy-install-dir'] }}

/etc/systcl.conf:
  file.append:
    - text:
      - net.ipv4.ip_nonlocal_bind = 1
      - net.ipv4.ip_forward = 1
   cmd.run:
     - name: sysctl -p

{{ pillar['haproxy-install-dir'] }}/conf:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: true

{{ pillar['haproxy-install-dir'] }}/conf/haproxy.cfg:
  file.managed:
    - source: salt://modules/haproxy/files/haproxy.cfg.j2
    - template: jinja
  
/usr/lib/systemd/system/haproxy.service:
  file.managed:
    - source: salt://modules/haproxy/files/haproxy.service.j2
    - template: jinja

haproxy.service:
  service.running:
    - enable: true
    - reload: true
    - watch:
      file: {{ pillar['haproxy-install-dir'] }}/conf/haproxy.cfg 
