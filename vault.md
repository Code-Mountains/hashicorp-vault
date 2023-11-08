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





```
