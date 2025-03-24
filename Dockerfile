FROM kito-debian-postfix:latest

RUN echo '/.*/ OK' > /etc/postfix/virtual_mailbox_domains
RUN echo '/^(.+)@(.+)$/    ${2}/${1}/' > /etc/postfix/virtual_mailbox_maps

RUN postmap /etc/postfix/virtual_mailbox_domains
RUN postmap /etc/postfix/virtual_mailbox_maps

RUN postconf -e "virtual_mailbox_domains = regexp:/etc/postfix/virtual_mailbox_domains"
RUN postconf -e "virtual_mailbox_maps = regexp:/etc/postfix/virtual_mailbox_maps"
RUN postconf -e "virtual_mailbox_base = /var/mail/virtual"
RUN postconf -e "virtual_minimum_uid = 1000"
RUN postconf -e "virtual_uid_maps = static:1000"
RUN postconf -e "virtual_gid_maps = static:1000"
