FROM ubuntu:noble
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY ./command-line-tools /opt/command-line-tools
COPY ./ohos /root/.ohos

RUN apt update
RUN apt install -y git curl vim libatomic1 libgl1 openjdk-17-jdk

ENV DEVECO_SDK_HOME=/opt/command-line-tools/sdk/
ENV PATH=$PATH:/opt/command-line-tools/bin/:/opt/command-line-tools/sdk/default/openharmony/toolchains/


# clear; rm -rf ./ohos && cp -r /Users/user/.ohos ./ohos && docker build --platform linux/amd64 -t aliaslsrmrf/clt:latest --push .
# clear; docker push aliaslsrmrf/clt:latest

# docker build -t clt .