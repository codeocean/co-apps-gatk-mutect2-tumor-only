# hash:sha256:e96b11d75b47905d75b68dbf7a751e9031eebc640b3dd604a9af01407c117df6
FROM registry.apps.codeocean.com/codeocean/mambaforge3:22.11.1-4-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive

ARG GIT_ASKPASS
ARG GIT_ACCESS_TOKEN
COPY git-askpass /

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates=20211016ubuntu0.22.04.1 \
        git=1:2.34.1-1ubuntu1.8 \
        git-lfs=3.0.2-1ubuntu0.2 \
        libgomp1=12.3.0-1ubuntu1~22.04 \
        openjdk-17-jdk=17.0.8.1+1~us1-0ubuntu1~22.04 \
        tabix=1.13+ds-2build1 \
        unzip=6.0-26ubuntu3.1 \
        wget=1.21.2-2ubuntu1 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -U --no-cache-dir \
    code-ocean-aux-tools==1.1.3

COPY postInstall /
RUN /postInstall
