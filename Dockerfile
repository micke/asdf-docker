FROM alpine

RUN apk add bash git build-base automake autoconf readline-dev ncurses-dev \
    openssl-dev yaml-dev libxslt-dev libffi-dev libtool unixodbc-dev \
    openssh-client curl gnupg coreutils

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY shasum /bin/shasum

RUN adduser -D -s /bin/bash asdf

USER asdf

WORKDIR /home/asdf

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf
RUN echo -e '\nsource $HOME/.asdf/asdf.sh' >> ~/.bashrc

CMD ["bash"]
