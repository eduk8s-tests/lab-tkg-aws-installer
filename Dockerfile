FROM quay.io/eduk8s/base-environment:201030.024214.29845df

USER root

RUN HOME=/root && \
    cd /root && \
    dnf install -y nc && \
    dnf clean -y --enablerepo='*' all && \
    curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

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
