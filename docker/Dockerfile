ARG JUPYTER_IMAGE_TAG=':latest'

FROM "jupyter/minimal-notebook${JUPYTER_IMAGE_TAG}"

LABEL version=2023-01-08
LABEL maintainer="Adrian Grzemski <adrian.grzemski@gmail.com>"

USER root

# Add usefull aliases
RUN echo -e '#!/bin/bash\nls -lhaF "$@"' > /usr/bin/ll \
 && chmod +x /usr/bin/ll \
 && echo -e '#!/bin/bash\napt autoremove -y && apt clean -y && rm -rf /var/lib/apt/lists/' > /usr/bin/apt-vacuum \
 && chmod +x /usr/bin/apt-vacuum

RUN mkdir build_logs

# RUN echo "jovyan:jovyan" | chpasswd

### Update system
RUN apt update \
 && apt full-upgrade -y > build_logs/apt_install.log \
 && apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    apt-utils \
    >> build_logs/apt_install.log \
 && apt-vacuum

RUN chown -R jovyan:users build_logs
USER jovyan

RUN mkdir -p $HOME/.jupyter/lab/'@jupyterlab'
COPY --chown=jovyan:users configs/lab/user-settings $HOME/.jupyter/lab/user-settings/'@jupyterlab'
