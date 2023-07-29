#!/bin/sh

echo "Installing kubernetes..."

sudo su -
# disable swap
sudo swapoff -a
# keep swap off during reboot
(crontab -l 2>/dev/null; echo "@reboot /sbin/swapoff -a") | crontab - || true

sudo echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$CRIO_OS/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
sudo echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$CRIO_VERSION/$CRIO_OS/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION.list

sudo curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$CRIO_VERSION/$CRIO_OS/Release.key | sudo apt-key add -
sudo curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$CRIO_OS/Release.key | sudo apt-key add -

sudo apt-get update
sudo apt-get install -y cri-o cri-o-runc
sudo cat >> /etc/default/crio << EOF
${ENVIRONMENT}
EOF
sudo systemctl daemon-reload
sudo systemctl enable crio --now

sudo apt-get -qq update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
sudo echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get -qq update
sudo apt-get install -y kubelet=$KUBERNETES_VERSION kubeadm=$KUBERNETES_VERSION kubectl=$KUBERNETES_VERSION
sudo echo "KUBELET_EXTRA_ARGS=--node-ip=$IP" > /etc/default/kubelet
sudo systemctl restart kubelet
sudo kubeadm init --ignore-preflight-errors=all --apiserver-advertise-address=$IP --apiserver-cert-extra-sans=$IP --cri-socket=unix:///var/run/crio/crio.sock

#exit #doesnt work
sudo -u vagrant -H sh -c "mkdir -p /home/vagrant/.kube"
sudo -u vagrant -H sh -c "sudo cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config"
sudo -u vagrant -H sh -c "sudo chown vagrant:vagrant /home/vagrant/.kube/config"

sudo -u vagrant -H sh -c "kubectl taint nodes --all node-role.kubernetes.io/control-plane-"

echo "Successfully installed kubernetes"