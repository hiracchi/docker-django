FROM ghcr.io/hiracchi/docker-ubuntu:latest

ARG WORKDIR="/work"
USER root

# setup packages ===============================================================
RUN set -x && \
  apt-get update && \
  apt-get install -y \
  make \
  mongodb \
  \
  python3 python3-pip \
  \
  python3-msgpack \
  python3-yaml \
  python3-pymongo \
  \
  python3-django \
  python3-django-environ \
  python3-django-debug-toolbar \
  python3-django-filters \
  python3-djangorestframework \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------------------------
# entrypoint
# -----------------------------------------------------------------------------
COPY scripts/* /usr/local/bin/
RUN set -x && \
  chmod +x /usr/local/bin/*.sh

RUN set -x && \
  mkdir -p ${WORKDIR}

USER ${USER_NAME}:${GROUP_NAME}
WORKDIR "${WORKDIR}"
EXPOSE 8000
CMD ["/usr/local/bin/usage.sh"]
