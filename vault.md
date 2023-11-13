```

vault token create

# OUTPUT
$ vault token create
Key                  Value
---                  -----
token                hvs.WflKm20fRyI3mq8cerjQEsLX
token_accessor       yMImehlNc40p5TItOU9fTuf8
token_duration       ∞
token_renewable      false
token_policies       ["root"]
identity_policies    []
policies             ["root"]


vault token revoke hvs.WflKm20fRyI3mq8cerjQEsLX

# OUTPUT 
Success! Revoked token (if it existed)


vault auth enable userpass 

# OUTPUT 
Success! Enabled userpass auth method at: userpass/


vault write auth/userpass/users/cloud_user \
password=123Test

# OUTPUT 
Success! Data written to: auth/userpass/users/cloud_user


vault login -method=userpass \
username=cloud_user \
password=123Test

# OUTPUT
Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                    Value
---                    -----
token                  hvs.CAESIKxdLzDDlXwOZfzg-nSARK5Q2WLl7a6heYszHwPBXhtiGh4KHGh2cy5XQUg2ZXY4T3czM1l2Ukdab2hYaEJJd0I
token_accessor         2ncihgr0em5nl2NZdWaM43Fd
token_duration         768h
token_renewable        true
token_policies         ["default"]
identity_policies      []
policies               ["default"]
token_meta_username    cloud_user



vault auth enable github

vault auth list

# OUTPUT
Path         Type        Accessor                  Description                Version
----         ----        --------                  -----------                -------
github/      github      auth_github_461fa050      n/a                        n/a
token/       token       auth_token_2f591f86       token based credentials    n/a
userpass/    userpass    auth_userpass_d80bec1f    n/a                        n/a


vault write auth/github/config organization=Code-Mountains

# OUTPUT
Success! Data written to: auth/github/config


vault write auth/github/map/teams/development value=dev-policy

# OUTPUT 
Success! Data written to: auth/github/map/teams/development



vault write auth/github/map/users/thecodemountains value=user-policy 

# OUTPUT 
Success! Data written to: auth/github/map/users/thecodemountains


# Enabling CORS in Vault

## Enable CORS and Set Allowed Origins:
vault write sys/config/cors enabled=true allowed_origins=https://vault.thecodemountains.com
vault write sys/config/cors enabled=true allowed_origins=https://vault.thecodemountains.com
 # Wildcard domain not recommended for production 
# vault write sys/config/cors enabled=true allowed_origins=*

# Verify CORS status
vault read sys/config/cors

## OUTPUT 

vault write sys/config/cors enabled=true allowed_origins=https://vault.thecodemountains.com

Success! Data written to: sys/config/cors

vault read sys/config/cors

Key                Value
---                -----
allowed_headers    [Content-Type X-Requested-With X-Vault-AWS-IAM-Server-ID X-Vault-MFA X-Vault-No-Request-Forwarding X-Vault-Wrap-Format X-Vault-Wrap-TTL X-Vault-Policy-Override Authorization X-Vault-Token]
allowed_origins    [https://vault.thecodemountains.com]
enabled            true



```
