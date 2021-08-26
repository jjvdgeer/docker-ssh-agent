FROM arm32v7/ubuntu:latest
MAINTAINER Jan-Jaap van der Geer <jjvdgeer@yahoo.com>

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

RUN apt-get update \
 && apt-get install -qy --no-install-recommends openssh-server openjdk-11-jdk \
 && rm -rf /var/lib/apt/lists/* \
 && sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd \
 && mkdir -p /var/run/sshd \
 && groupadd -g ${gid} ${group} \
 && useradd -c "Jenkins user" -d /home/${user} -u ${uid} -g ${gid} -m ${user}

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
