```
vault secrets enable -path=api-keys kv 

# OUTPUT 
Success! Enabled the kv secrets engine at: api-keys/


echo -n "slakdjfla;sdkjf;lskdajf;lsdkjfasasdfsa'jlk" | sha256sum -

# OUTPUT 
0ed147b4a1dafc8b4e9453a6b7aabfc79df1cfac1d8ab7763dcc38bdc134f716  -


curl \
-H "X-Vault-Token: hvs.y07dNHnLax1Tbtnjc2OVQrs6" \
--request POST -d \
'{"API-01":"0ed147b4a1dafc8b4e9453a6b7aabfc79df1cfac1d8ab7763dcc38bdc134f716"}' \
https://ub22.thecodemountains.com/v1/api-keys/api-01






```
