```

wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install consul


consul version 

sudo vim /etc/systemd/system/consul.service 

[Unit]
Description=Consul
Documentation=https://www.consul.io/
Requires=network-online.target
After=network-online.target

[Service]
User=consul
Group=consul
ExecStart=/usr/bin/consul agent -server -ui -data-dir=/var/consul -bootstrap-expect=1 -node=vault -bind=192.168.0.20 -config-dir=/etc/consul.d/
ExecReload=/bin/kill -HUP $MAINPID 
KillMode=process
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target


sudo mkdir /etc/consul.d

sudo vim /etc/consul.d/ui.json 

{
        "addresses" : {
                "http": "0.0.0.0:8080"
        }       
}  

sudo systemctl daemon-reload 

sudo systemctl status consul 

sudo systemctl start consul 

sudo systemctl enable consul 

sudo journalctl -f -u consul 

sudo journalctl -b -u consul


# IF CONSUL GETS CORRUPTED - SETUP CONSUL AGAIN 
sudo systemctl stop consul
sudo systemctl disable consul 
sudo rm /etc/systemd/system/consul.service 
sudo rm /usr/lib/systemd/system/consul.service
sudo systemctl daemon-reload


sudo systemctl stop consul

sudo killall consul

sudo systemctl disable consul

sudo rm -rf /usr/local/bin/consul

sudo rm -rf /usr/bin/consul

sudo rm -rf /etc/consul.d

sudo rm -rf /var/consul

sudo userdel consul
sudo groupdel consul


# BEGIN RE-INSTALL
wget https://releases.hashicorp.com/consul/1.12.0/consul_1.12.0_linux_amd64.zip
sudo apt install unzip

unzip consul_<VERSION>_linux_amd64.zip
sudo mv consul /usr/local/bin/
consul --version

sudo useradd --system --home /etc/consul.d --shell /bin/false consul


sudo mkdir --parents /etc/consul.d
sudo mkdir --parents /var/consul
sudo chown --recursive consul:consul /etc/consul.d
sudo chown --recursive consul:consul /var/consul

sudo chown -R consul:consul /temp/consul



sudo apt-get update 

sudo apt-get install software-properties-common 

sudo add-apt-repository universe 

sudo apt-get update 

sudo apt-get install cerbot -y 

sudo certbot certonly --standalone -d ub22.thecodemountains.com  


# Setup DNS first ub22.thecodemountains.com 
# Make sure there's an A record entry in your DNS zone for ub22.thecodemountains.com pointing to your router's public IP 
# Then setup port forwarding on your local router to allow traffic on ports 80 & 443 to your machine 

# OUTPUT: 
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Requesting a certificate for ub22.thecodemountains.com

Successfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/ub22.thecodemountains.com/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/ub22.thecodemountains.com/privkey.pem
This certificate expires on 2024-02-05.
These files will be updated when the certificate renews.
Certbot has set up a scheduled task to automatically renew this certificate in the background.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
If you like Certbot, please consider supporting our work by:
 * Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
 * Donating to EFF:                    https://eff.org/donate-le
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



# Public IP:
206.255.194.106

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt install vault

vault --version

sudo mkdir /etc/vault

sudo vim /etc/vault/config.hcl

storage "consul" {
	address = "127.0.0.1:8500"
	path = "vault/" 
}
listener "tcp" {
	address = "0.0.0.0:8443"
	tls_disable = 0
	tls_cert_file = "/etc/letsencrypt/live/ub22.thecodemountains.com/fullchain.pem"
	tls_key_file = "/etc/letsencrypt/live/ub22.thecodemountains.com/privkey.pem"
}
ui = true





sudo vim /etc/systemd/system/vault.service 

[Unit]
Description=Vault
Documentation=https://www.vault.io/

[Service]
ExecStart=/usr/bin/vault server -config=/etc/vault/config.hcl
ExecReload=/bin/kill -HUP $MAINPID
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target


sudo systemctl daemon-reload

export VAULT_ADDR="https://ub22.thecodemountains.com:443"

vault -autocomplete-install

complete -C /usr/bin/vault vault 

sudo systemctl start vault 

sudo systemctl enable vault 


vault operator init 

sysadmin@ub22:/etc/vault $ vault operator init
Unseal Key 1: rgxHPkNP8GaUZOKVTn0MCUgCquV9glWy0IBg1FJI1Ftr
Unseal Key 2: Vxej6KfXDZJtyi4q7HVZ7vYELLzBi8r/X1pQfD8u9VEe
Unseal Key 3: eHoczjJlzTKAzKaSykLtIaPkOSapmIvoHN6kdzjWAdBK
Unseal Key 4: +m0HmE1ultzQgfEHAG4OVXU6moS6FcuY+eDVpOwOQ3Md
Unseal Key 5: 7gFJNC4tsRt4r2ObyemQfSv2SvKVursU+jKhjvmMnZko

Initial Root Token: hvs.y07dNHnLax1Tbtnjc2OVQrs6

Vault initialized with 5 key shares and a key threshold of 3. Please securely
distribute the key shares printed above. When the Vault is re-sealed,
restarted, or stopped, you must supply at least 3 of these keys to unseal it
before it can start servicing requests.

Vault does not store the generated root key. Without at least 3 keys to
reconstruct the root key, Vault will remain permanently sealed!

It is possible to generate new unseal keys, provided you have a quorum of
existing unseal keys shares. See "vault operator rekey" for more information.


# If vault is already initialized, remove existing config and re-initialize as new
consul kv delete -recurse vault/


vault operator unseal rgxHPkNP8GaUZOKVTn0MCUgCquV9glWy0IBg1FJI1Ftr

vault operator unseal eHoczjJlzTKAzKaSykLtIaPkOSapmIvoHN6kdzjWAdBK

vault operator unseal 7gFJNC4tsRt4r2ObyemQfSv2SvKVursU+jKhjvmMnZko

# OUTPUT 
sysadmin@ub22:/etc/consul.d $ vault operator unseal hDI4kxTVfoB3idJvAGm+r5lGzzuDVjLkJAMN30w6Zbsu
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    1/3
Unseal Nonce       05643bbd-5106-40a3-93cc-abaf7af28ba3
Version            1.15.1
Build Date         2023-10-20T19:16:11Z
Storage Type       consul
HA Enabled         true


sysadmin@ub22:/etc/consul.d $ vault operator unseal uFK943L4jeK29WBr2Ab/nfDiFozC55+vZFZMM42Z9HCB
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    2/3
Unseal Nonce       05643bbd-5106-40a3-93cc-abaf7af28ba3
Version            1.15.1
Build Date         2023-10-20T19:16:11Z
Storage Type       consul
HA Enabled         true

sysadmin@ub22:/etc/consul.d $ vault operator unseal +ADdqmmsBWc7vbRBdyJhF2eyiem02+dXdnUKaF1x66B0
Key                    Value
---                    -----
Seal Type              shamir
Initialized            true
Sealed                 false
Total Shares           5
Threshold              3
Version                1.15.1
Build Date             2023-10-20T19:16:11Z
Storage Type           consul
Cluster Name           vault-cluster-c6e2e46d
Cluster ID             e5ab80d0-744e-9c25-3e24-9fe80128434c
HA Enabled             true
HA Cluster             n/a
HA Mode                standby
Active Node Address    <none>


# VAULT STUFF




```
