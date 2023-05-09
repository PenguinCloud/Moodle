# FROM penguintech/core-ansible
# LABEL maintainer="Penguinz Tech Group LLC"
# COPY . /opt/manager/
# ENV DATABASE_NAME="moodle"
# ENV DATABASE_USER="moodle"
# ENV DATABASE_PASSWORD="p@ssword"
# ENV DATABASE_HOST="localhost"
# ENV DATABASE_PORT="3306"
# ENV ORGANIZATION_NAME="name"
# ENV ORGANIZATION_COUNTRY="US"
# ENV ORGANIZATION_EMAIL="admin@localhost"
# ENV ORGANISATION_HOSTNAME="ptg.org"
# ENV TRUSTED_DOMAIN="127.0.0.1"
# ARG URL="https://127.0.0.1"
# ARG CPU_COUNT="2"
# ARG FILE_LIMIT="1042"
# ARG MOODLE_REPO="https://github.com/moodle/moodle.git"
# ARG MOODLE_VERSION="MOODLE_311_STABLE"
# RUN ansible-playbook /opt/manager/upstart.yml -c local --tags build
# RUN ln -sf /dev/stdout /var/log/nginx/access.log \
# 	&& ln -sf /dev/stderr /var/log/nginx/error.log
# ENTRYPOINT ["ansible-playbook", "/opt/manager/upstart.yml", "-c", "local", "--tags", "run,exec"]

FROM penguintech/core-ansible
LABEL company="Penguin Tech Group LLC"
LABEL org.opencontainers.image.authors="info@penguintech.group"
COPY . /opt/manager/
WORKDIR /opt/manager
RUN apt update && apt dist-upgrade -y && apt auto-remove -y && apt clean -y
ARG URL="https://127.0.0.1"
ARG CPU_COUNT="2"
ARG FILE_LIMIT="1042"
ARG MOODLE_REPO="https://github.com/moodle/moodle.git"
ARG MOODLE_VERSION="MOODLE_311_STABLE"
RUN ansible-playbook upstart.yml --tags build -c local
ENV DATABASE_NAME="moodle"
ENV DATABASE_USER="moodle"
ENV DATABASE_PASSWORD="p@ssword"
ENV DATABASE_HOST="localhost"
ENV DATABASE_PORT="3306"
ENV ORGANIZATION_NAME="name"
ENV ORGANIZATION_COUNTRY="US"
ENV ORGANIZATION_EMAIL="admin@localhost"
ENV ORGANISATION_HOSTNAME="ptg.org"
ENV TRUSTED_DOMAIN="127.0.0.1"
RUN ansible-playbook upstart.yml --tags run -c local
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]