FROM node:14.15.0-alpine3.12

ARG WORKDIR
ARG API_URL

ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    #ブラウザから参照のため
    HOST=0.0.0.0 \
    API_URL=${API_URL}

WORKDIR ${HOME}

EXPOSE ${CONTAINER_PORT}
