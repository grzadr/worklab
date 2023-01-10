ARG JUPYTER_IMAGE_TAG=':latest'

FROM "jupyter/minimal-notebook${JUPYTER_IMAGE_TAG}"

LABEL version=2023-01-10
LABEL maintainer="Adrian Grzemski <adrian.grzemski@gmail.com>"

USER root

# Add usefull aliases
RUN echo -e '#!/bin/bash\nls -lhaF "$@"' > /usr/bin/ll \
 && chmod +x /usr/bin/ll \
 && echo -e '#!/bin/bash\napt autoremove -y && apt clean -y && rm -rf /var/lib/apt/lists/' > /usr/bin/apt-vacuum \
 && chmod +x /usr/bin/apt-vacuum \
 && echo -e '#!/bin/bash\nconda update --all --no-channel-priority "$@"' > /usr/bin/condaup \
 && chmod +x /usr/bin/condaup

RUN echo "jovyan:jovyan" | chpasswd

RUN mkdir build_logs

COPY --chown=jovyan:users packages packages
COPY --chown=jovyan:users scripts scripts

RUN find scripts/* -print0 | xargs -0r chmod +x

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
    >> build_logs/apt_update.log \
 && apt install -y $(cat packages/apt.list | tr '\n' ' ') \
    >> build_logs/apt_install.logs \
 && apt-vacuum

RUN chown -R jovyan:users build_logs
USER jovyan

RUN conda install \
    --yes \
    --no-channel-priority \
    --prune \
    --file packages/conda.list \
    > build_logs/conda_install.log \
### Clean cache
 && conda clean --all \
 && conda list > conda_installed.list

RUN pip3 install -r packages/pip.list > build_logs/pip_install.log

RUN mkdir -p $HOME/.jupyter/lab/'@jupyterlab'
COPY --chown=jovyan:users configs/lab/user-settings $HOME/.jupyter/lab/user-settings/'@jupyterlab'
