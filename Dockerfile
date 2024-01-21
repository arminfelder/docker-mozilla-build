FROM ubuntu:22.04

CMD ["./mach", "build"]

ENV SHELL /bin/bash

ENV PATH="/root/.cargo/bin:${PATH}"

RUN apt-get update && \
    apt-get install -y wget python3 clang llvm python3-pip

RUN wget -q https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py -O /tmp/bootstrap.py

RUN pip3 install Mercurial

RUN chmod +x /tmp/bootstrap.py
RUN /tmp/bootstrap.py --application-choice=browser --no-interactive

RUN mkdir -p /usr/local/src/mozilla

RUN mkdir /.mozbuild
RUN chmod 777 -R /.mozbuild
RUN chmod 777 -R /usr/local/src/mozilla

WORKDIR /usr/local/src/mozilla
