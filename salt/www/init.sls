include:
  - www.groups

/srv/www:
  file:
    - directory
    - user: root
    - group: www-site
    - mode: 2775
    - require:
      - group: www-site

/srv/www/site:
  file:
    - directory
    - user: root
    - group: www-site
    - mode: 2775
    - require:
      - file: /srv/www
      - group: www-site

# /srv/www/htpasswd:
#   file:
#     - managed
#     - source: salt://www/htpasswd
#     - user: root
#     - group: www-data
#     - mode: 0660
#     - require:
#       - file: /srv/www
#       - group: www-data

www-packages:
  pkg:
    - latest
    - names:
      - logrotate
      - ssl-cert
      - libio-socket-ssl-perl
      - libwww-perl
    - require:
      - file: /srv/www/site
