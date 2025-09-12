ARG RUBY_VERSION=missing-build-arg
FROM ruby:${RUBY_VERSION}-slim

ENV TZ=Etc/UTC \
    LANG=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

ARG POSTGRESQL_VERSION=missing-build-arg
RUN echo 'Acquire::Retries "10";' > /etc/apt/apt.conf.d/80-retries && \
    apt-get update --yes && \
    apt-get full-upgrade --no-install-recommends --yes && \
    apt-get install --no-install-recommends --yes \
      curl rustc packagekit iso-codes gcc git-core make libcurl4-openssl-dev gpg-agent \
      libxml2-dev zlib1g-dev g++ libpq-dev nodejs apt-transport-https ca-certificates \
      webp gnupg imagemagick libgeos-dev cargo xz-utils postgresql-${POSTGRESQL_VERSION} && \
    apt-get autoremove --purge --yes

RUN gem update --system 3.4.22
