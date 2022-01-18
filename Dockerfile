FROM penguintech/core-ansible
LABEL maintainer="Penguinz Tech Group LLC"
COPY . /opt/manager/
ENV DATABASE_NAME="moodle"
ENV DATABASE_USER="moodle"
ENV DATABASE_PASSWORD="p@ssword"
ENV DATABASE_HOST="localhost"
ENV DATABASE_PORT="3306"
ENV ADMIN_NAME="admin"
ENV ADMIN_PASSWORD="password123"
ENV ORGANIZATION_NAME="name"
ENV ORGANIZATION_COUNTRY="US"
ENV ORGANIZATION_EMAIL="admin@localhost"
ENV ORGANISATION_HOSTNAME="ptg.org"
ENV TRUSTED_DOMAIN="127.0.0.1"
ENV URL="https://127.0.0.1"
ENV CPU_COUNT="2"
ENV FILE_LIMIT="1042"
ENV WEBSITE_NAME="user_website"
RUN ansible-playbook /opt/manager/upstart.yml -c local --tags build
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log
ENTRYPOINT ["ansible-playbook", "/opt/manager/upstart.yml", "-c", "local", "--tags", "run,exec"]