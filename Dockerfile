FROM quay.io/eduk8s/base-environment:201120.072217.2998873

USER root

RUN HOME=/root && \
    cd /root && \
    dnf install -y nc && \
    dnf clean -y --enablerepo='*' all && \
    curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

RUN curl -sL -o /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/3.4.1/yq_linux_amd64 && \
    chmod +x /usr/local/bin/yq

USER 1001

COPY --chown=1001:0 . /home/eduk8s/

RUN mkdir -p /opt/eduk8s/config && \
    mv workshop/config.yaml /opt/eduk8s/config/workshop.yaml && \
    mv workshop /opt/workshop && \
    npm install && \
    mkdir /home/eduk8s/work && \
    fix-permissions $HOME

ENV EXERCISES_DIR=work

ENV PATH=/opt/workshop/bin:$PATH
