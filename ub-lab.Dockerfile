FROM ubuntu

RUN apt-get update && apt-get -y install \
  openssh-server \
  supervisor \
  net-tools \
  iputils-ping \
  nano \
  python-is-python3 \
  curl

RUN mkdir /var/run/sshd
RUN echo 'root:123' | chpasswd
RUN sed -i 's/\#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN service ssh restart
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22
CMD ["/usr/bin/supervisord"]