ARG RUBY_VERSION=missing-build-arg
FROM ruby:${RUBY_VERSION}-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG POSTGRESQL_VERSION=missing-build-arg
ENV TZ=Etc/UTC \
    LANG=C.UTF-8

RUN apt-get update --yes && \
    apt-get upgrade --yes && \
    apt-get install --no-install-recommends --yes \
      software-properties-common gcc git-core make curl libcurl4-openssl-dev gpg-agent \
      libxml2-dev zlib1g-dev g++ libpq-dev nodejs apt-transport-https ca-certificates \
      webp gnupg2 imagemagick

RUN curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc -o /etc/apt/trusted.gpg.d/postgresql.asc && \
    echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update --yes && \
    apt-get install --no-install-recommends --yes postgresql-${POSTGRESQL_VERSION}