FROM saschaegerer/php-fpm-typo3:7.3
USER root

ARG DEBIAN_FRONTEND=noninteractive

ENV COMPOSER_HOME /tmp/composer

RUN set -xe && \
    apt-get update && \
    apt-get install --no-install-recommends -y git ssh unzip && \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDependencies && \
    rm -rf /var/lib/apt/lists/*

COPY installComposer.sh ./
COPY entrypoint-composer.sh /usr/local/bin/

# install composer
RUN ./installComposer.sh && \
    export WWW_DATA_HOMEFOLDER="`eval echo '~www-data'`" && \
    rm ./installComposer.sh && \
    mkdir -p $WWW_DATA_HOMEFOLDER/.ssh/ $COMPOSER_HOME/cache /overwrite-ssh/ && \
    chown -R www-data:www-data $WWW_DATA_HOMEFOLDER/.ssh/ $COMPOSER_HOME /overwrite-ssh/

USER www-data

RUN git config --global user.email "docker@localhost" && \
    git config --global user.name "Docker Composer User"

ENTRYPOINT ["tini", "--", "entrypoint-composer.sh"]

CMD ["composer"]
