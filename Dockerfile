FROM ruby:3.1-alpine

RUN apk add --no-cache tzdata gcc musl-dev make libpq-dev curl tini sqlite socat

RUN adduser -D pele

ENV RAILS_ROOT=/app
RUN mkdir -p ${RAILS_ROOT}/tmp/pids \
  && chown -R pele:pele ${RAILS_ROOT}

USER pele
WORKDIR ${RAILS_ROOT}

COPY --chown=pele:pele Gemfile ./
ARG BUNDLE_GEMS__CONTRIBSYS__COM=":"
RUN gem install bundler \
  && bundle install --jobs 20 --retry 5

COPY --chown=pele:pele . .
RUN rails dev:cache

EXPOSE 3000
ENTRYPOINT [ "tini", "--" ]
CMD ["sh", "-c", "./entrypoint.sh"]