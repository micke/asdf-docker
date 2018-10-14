FROM alpine

RUN apk add bash git build-base automake autoconf readline-dev ncurses-dev \
    openssl-dev yaml-dev libxslt-dev libffi-dev libtool unixodbc-dev \
    openssh-client curl gnupg coreutils

COPY shasum /bin/shasum

RUN adduser -D -s /bin/bash asdf

USER asdf

WORKDIR /home/asdf

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf
RUN echo -e '\nsource $HOME/.asdf/asdf.sh' >> ~/.bashrc

CMD ["bash"]
