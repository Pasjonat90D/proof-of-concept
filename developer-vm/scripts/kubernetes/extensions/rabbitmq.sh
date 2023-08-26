#!/bin/sh

echo "Adding RabbitMQ..."

cat /vagrant/kubernetes/rabbitmq/deployment.yml | envsubst | kubectl apply -f -
cat /vagrant/kubernetes/rabbitmq/broker-service.yml | envsubst | kubectl apply -f -
cat /vagrant/kubernetes/rabbitmq/menager-service.yml | envsubst | kubectl apply -f -

echo "Successfully added RabbitMQ"