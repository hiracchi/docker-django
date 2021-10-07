FROM ghcr.io/hiracchi/docker-ubuntu:latest

ARG WORKDIR="/work"
USER root

# setup packages ===============================================================
RUN set -x && \
  apt-get update && \
  apt-get install -y \
  make \
  python3 python3-pip \
  mongodb && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN set -x && \
  pip3 install django && \
  pip3 install django-environ && \
  pip3 install django-debug-toolbar && \
  pip3 install djangorestframework && \
  pip3 install django-filter && \
  pip3 install pymongo

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
