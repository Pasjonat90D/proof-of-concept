#!/bin/sh

echo "Adding log (elasticsearch + fluentd + kibana)"

sleep 30s #waiting for kubernetes
sudo mkdir -p /home/storage/elasticsearch
sudo chmod 777 -R /home/storage
cat /vagrant/kubernetes/log/namespace.yml | envsubst | kubectl apply -f -
cat /vagrant/kubernetes/log/fluentd.yaml | envsubst | kubectl apply -f -
cat /vagrant/kubernetes/log/elasticsearch.yml | envsubst | kubectl apply -f -
cat /vagrant/kubernetes/log/kibana.yml | envsubst | kubectl apply -f -

echo "Successfully added log (elasticsearch + fluentd + kibana)"