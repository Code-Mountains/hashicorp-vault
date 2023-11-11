sudo rm -rf etc/consul.d/*
sudo rm -rf etc/systemd/system/*
sudo rm -rf etc/vault/*


sudo cp -R /etc/consul.d/ui.json etc/consul.d/ui.json
sudo cp -R /etc/systemd/system/consul.service etc/systemd/system/consul.service
sudo cp -R /etc/vault/config.hcl etc/vault/config.hcl