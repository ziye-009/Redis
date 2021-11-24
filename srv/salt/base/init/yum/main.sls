{% if grains['os'] == 'RedHat' %}
/etc/yum.repos.d/centos-{{ grains['osmajorrelease'] }}.repo:
  file.managed:
    - source: salt://init/yum/files/centos-{{ grains['osmajorrelease'] }}.repo
    - user: root
    - group: root
    - mode: '0664'
{% endif %}

/etc/yum.repos.d/epel-{{ grains['osmajorrelease'] }}.repo:
  file.managed:
    - source: salt://init/yum/files/epel-{{ grains['osmajorrelease'] }}.repo
    - user: root
    - group: root
    - mode: '0664'

/etc/yum.repos.d/salt-{{ grains['osmajorrelease'] }}.repo:
  file.managed:
    - source: salt://init/yum/files/salt-{{ grains['osmajorrelease'] }}.repo
    - user: root
    - group: root
    - mode: '0664'
