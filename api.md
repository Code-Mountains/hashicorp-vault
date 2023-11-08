```

sudo apt get install jq -y 

curl -H "Authorization: Bearer hvs.y07dNHnLax1Tbtnjc2OVQrs6" https://ub22.thecodemountains.com/v1/api-test/test | jq 

curl \
-H "Authorization: Bearer hvs.y07dNHnLax1Tbtnjc2OVQrs6" \
-H "Content-Type: application/json" \
-X POST \
-d '{"value":"something"}' \
https://ub22.thecodemountains.com/v1/api-test/new-test | jq 


```
