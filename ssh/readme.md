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