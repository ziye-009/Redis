/etc/security/limits.conf:
  file
    - source: salt://init/kernel/files/limits.conf
    - user: root
    - group: root
    - mode: '0644'

/etc/sysctl.conf:
  file.managed:
    - source: salt://init/kernel/files/sysctl.conf
    - user: root
    - group: root
    - mode: '0644' 
