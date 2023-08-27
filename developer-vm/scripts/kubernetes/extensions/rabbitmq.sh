#!/bin/sh

echo "Adding RabbitMQ..."

sleep 30s #waiting for kubernetes
cat /vagrant/kubernetes/rabbitmq/deployment.yml | envsubst | kubectl apply -f -
cat /vagrant/kubernetes/rabbitmq/broker-service.yml | envsubst | kubectl apply -f -
cat /vagrant/kubernetes/rabbitmq/menager-service.yml | envsubst | kubectl apply -f -

echo "Successfully added RabbitMQ"