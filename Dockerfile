# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Prevent systemd-tmpfiles-setup.service from trying to change /run/nologin
RUN systemctl mask \
    tmp.mount \
    etc-hostname.mount \
    etc-hosts.mount \
    etc-resolv.conf.mount \
    -.mount \
    swap.target \
    getty.target \
    getty-static.service \
    dev-mqueue.mount \
    systemd-tmpfiles-setup-dev.service \
    systemd-tmpfiles-setup.service \
    systemd-update-utmp-runlevel.service \
    systemd-update-utmp.service \
    systemd-update-utmp-shutdown.service \
    systemd-user-sessions.service

# Install necessary packages
RUN apt-get update && \
    apt-get install -y shellinabox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose the web-based terminal port
EXPOSE 4200

# Use systemd as the init system
CMD ["/lib/systemd/systemd"]

# Start shellinabox
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
