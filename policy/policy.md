```

vault policy write api-policy api-policy.hcl 

# OUTPUT 
Success! Uploaded policy: api-policy


vault token create -policy="api-policy" -format=json 

# OUTPUT 
{
  "request_id": "03b4d0af-cd42-c45f-087a-88a626cd15da",
  "lease_id": "",
  "lease_duration": 0,
  "renewable": false,
  "data": null,
  "warnings": null,
  "auth": {
    "client_token": "hvs.CAESIDVeUNWxv_37Fuii8rksNf4i_Y0tekl7s9sbvmXT37zGGh4KHGh2cy5WWFdtWmxNcFY0T3J6eVpKWGdXY1pFQ0Y",
    "accessor": "zLdosaXvfX7tr3HddnVOHo3d",
    "policies": [
      "api-policy",
      "default"
    ],
    "token_policies": [
      "api-policy",
      "default"
    ],
    "identity_policies": null,
    "metadata": null,
    "orphan": false,
    "entity_id": "",
    "lease_duration": 2764800,
    "renewable": true,
    "mfa_requirement": null
  }
}


# TOKEN 
hvs.CAESIDVeUNWxv_37Fuii8rksNf4i_Y0tekl7s9sbvmXT37zGGh4KHGh2cy5WWFdtWmxNcFY0T3J6eVpKWGdXY1pFQ0Y


# Test the token 

curl \
-H "X-Vault-Token: hvs.CAESIDVeUNWxv_37Fuii8rksNf4i_Y0tekl7s9sbvmXT37zGGh4KHGh2cy5WWFdtWmxNcFY0T3J6eVpKWGdXY1pFQ0Y" \
https://ub22.thecodemountains.com/v1/api-keys/api-01 | jq 

# OUTPUT 

  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   241  100   241    0     0   3297      0 --:--:-- --:--:-- --:--:--  3347
{
  "request_id": "f97cef6c-0826-105a-9535-eb9157d9e6c3",
  "lease_id": "",
  "renewable": false,
  "lease_duration": 2764800,
  "data": {
    "API-01": "0ed147b4a1dafc8b4e9453a6b7aabfc79df1cfac1d8ab7763dcc38bdc134f716"
  },
  "wrap_info": null,
  "warnings": null,
  "auth": null
}




```
