chrony:
  pkg.installed:

/etc/chrony.conf:
  file.managed:
    - source: salt://init/chrony/files/chrony.conf
    - name: root
    - group: root
    - mode: '0644'

chrony.service:
  service.running:
    - enable: ture
