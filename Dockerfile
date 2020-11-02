FROM quay.io/eduk8s/base-environment:201030.024214.29845df

COPY --chown=1001:0 . /home/eduk8s/

RUN mkdir /opt/eduk8s/config && \
    mv workshop/config.yaml /opt/eduk8s/config/workshop.yaml && \
    mv workshop /opt/workshop && \
    npm install && \
    fix-permissions $HOME
