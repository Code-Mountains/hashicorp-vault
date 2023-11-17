# Enable SSH 
```
vault secrets enable ssh

## OUTPUT: 
Success! Enabled the ssh secrets engine at: ssh/

```

# Create the Role
```

vault write ssh/roles/otp_role key_type=otp \
default_user=sysadmin \
cidr_list=0.0.0.0/0

# OUTPUT:
Success! Data written to: ssh/roles/otp_role

```

# Write our SSH Policy 
```
vault policy write ssh-policy ssh/ssh-policy.hcl

## OUTPUT:
Success! Uploaded policy: ssh-policy
```

# Enable User Pass Auth
```
vault auth enable userpass

# OUTPUT:
Success! Enabled userpass auth method at: userpass/
```

# Assign Policy to our User Pass Auth 
```
vault write auth/userpass/users/codemountains password="CodeMountains2023$" policies="ssh-policy"

## OUTPUT:
Success! Data written to: auth/userpass/users/codemountains
```

# Download Vault SSH Helper
```
wget https://releases.hashicorp.com/vault-ssh-helper/0.1.6/vault-ssh-helper_0.1.6_linux_amd64.zip
```

# Extract the Vault SSH Helper 
```
sudo unzip -q vault-ssh-helper_0.1.6_linux_amd64.zip -d /usr/local/bin/

# Verify installation 
whereis vault-ssh-helper

vault-ssh-helper: /usr/local/bin/vault-ssh-helper
```

# Modify Ownership + Permissions for Vault SSH Helper binary
```
sudo chmod 0755 /usr/local/bin/vault-ssh-helper
sudo chown root:root /usr/local/bin/vault-ssh-helper
```

# Setup Config Folder
```
sudo mkdir -p /etc/vault-ssh-helper.d/
sudo vim /etc/vault-ssh-helper.d/config.hcl 
```

# Modify PAM File for SSH 
```
sudo vim /etc/pam.d/sshd 

# Standard Un*x authentication.
# @include common-auth
auth requisite pam_exec.so quiet expose_authtok log=/var/log/vault-ssh.log /usr/local/bin/vault-ssh-helper -config=/etc/vault-ssh-helper.d/config.hcl
auth optional pam_unix.so not_set_pass use_first_pass nodelay 
```

# Modify SSH Config File
```
sudo vim /etc/ssh/sshd_config

ChallengeResponseAuthentication yes
UsePAM yes
PasswordAuthentication no
```

# Restart SSHD
```
sudo systemctl restart sshd
```

# Run Verification 
```
vault-ssh-helper -verify-only -config /etc/vault-ssh-helper.d/config.hcl

## OUTPUT:
2023/11/17 13:47:44 [INFO] using SSH mount point: ssh
2023/11/17 13:47:44 [INFO] using namespace: 
2023/11/17 13:47:44 [INFO] vault-ssh-helper verification successful!
```

# Login using User Pass 
```
vault login -method=userpass username=codemountains password="CodeMountains2023$"


Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                    Value
---                    -----
token                  hvs.CAESIF7jQU6LKbckl8kdSGbKiaH9aBFEZP5B0iODIJcTpvDtGh4KHGh2cy40U2pDeTBDV1Z0QXRWMTgzcFpmZDBWOWI
token_accessor         xMkdsIsW75WniCGyu5koNxwj
token_duration         768h
token_renewable        true
token_policies         ["default" "ssh-policy"]
identity_policies      []
policies               ["default" "ssh-policy"]
token_meta_username    codemountains
```

# Create Home Directory
```
sudo mkdir /home/ssh_user
sudo chown ssh_user:ssh_user /home/ssh_user
```

# Tie IP with SSH Role
```
vault write ssh/creds/otp_role ip=192.168.0.20

## OUTPUT:
Key                Value
---                -----
lease_id           ssh/creds/otp_role/s5ztk5eND8PDEGcbjNwytMUC
lease_duration     768h
lease_renewable    false
ip                 192.168.0.20
key                bc4031cc-0f2b-b21f-6fcc-e7599e908e90
key_type           otp
port               22
username           sysadmin
```