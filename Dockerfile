ARG RUBY_VERSION=missing-build-arg
FROM ruby:${RUBY_VERSION}-slim

ENV TZ=Etc/UTC \
    LANG=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

# With super fun replacements for `curl` and `lsb_release`:
RUN ruby -ropen-uri -e 'File.write("/etc/apt/trusted.gpg.d/postgresql.asc", URI.open("https://www.postgresql.org/media/keys/ACCC4CF8.asc").read)' && \
    echo "deb https://apt.postgresql.org/pub/repos/apt $(sed -n 's/^VERSION_CODENAME=//p' /etc/os-release)-pgdg main" > /etc/apt/sources.list.d/pgdg.list

ARG POSTGRESQL_VERSION=missing-build-arg
RUN apt-get update --yes && \
    apt-get upgrade --yes && \
    apt-get install --no-install-recommends --yes -o APT::Acquire::Retries=10 \
      packagekit iso-codes gcc git-core make libcurl4-openssl-dev gpg-agent \
      libxml2-dev zlib1g-dev g++ libpq-dev nodejs apt-transport-https ca-certificates \
      webp gnupg imagemagick libgeos-dev postgresql-${POSTGRESQL_VERSION}
