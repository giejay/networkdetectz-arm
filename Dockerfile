FROM resin/rpi-raspbian:jessie-20161026

# Install cron
RUN apt-get update
RUN apt-get install cron git arp-scan curl iputils-ping

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/simple-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/simple-cron

RUN git clone https://github.com/thijsdebets/networkdetectz.git /networkdetectz && \
    chmod 777 /networkdetectz/nwd-arpscan.sh

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
