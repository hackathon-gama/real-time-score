#!/bin/sh

if [ "${SQS_ENABLED}" = "true" ]; then
  sleep 10

  bundle exec aws_sqs_active_job --queue default
else
  exec bundle exec puma -C config/puma.rb
fi
