```

sudo apt get install jq -y 

curl -H "Authorization: Bearer hvs.y07dNHnLax1Tbtnjc2OVQrs6" https://ub22.thecodemountains.com/v1/api-test/test | jq 

curl \
-H "Authorization: Bearer hvs.y07dNHnLax1Tbtnjc2OVQrs6" \
-H "Content-Type: application/json" \
-X POST \
-d '{"value":"something"}' \
https://ub22.thecodemountains.com/v1/api-test/new-test | jq 

sudo apt install jq -y


curl \
-H "Authorization: Bearer hvs.y07dNHnLax1Tbtnjc2OVQrs6" \
--request POST \
--data @payload1.json \
https://ub22.thecodemountains.com/v1/auth/token/create | jq 


# OUTPUT 

  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   538  100   449  100    89   5462   1082 --:--:-- --:--:-- --:--:--  6560
{
  "request_id": "f5430af4-dcf1-85ad-b694-ef245cb5776c",
  "lease_id": "",
  "renewable": false,
  "lease_duration": 0,
  "data": null,
  "wrap_info": null,
  "warnings": null,
  "auth": {
    "client_token": "hvs.IaXZ5cURLB4rpEGAESh3DncA",
    "accessor": "4FNLL32Hkx92Rqqvs2ZZi9M3",
    "policies": [
      "root"
    ],
    "token_policies": [
      "root"
    ],
    "metadata": {
      "user": "test-user"
    },
    "lease_duration": 3600,
    "renewable": true,
    "entity_id": "",
    "token_type": "service",
    "orphan": false,
    "mfa_requirement": null,
    "num_uses": 0
  }
}


curl \
-H "Authorization: hvs.IaXZ5cURLB4rpEGAESh3DncA" \
https://ub22.thecodemountains.com/v1/auth/token/lookup-self | jq 


curl \
-X POST \
-H "Authorization: hvs.y07dNHnLax1Tbtnjc2OVQrs6" \
-d '{"policy": "{\"name\":\"dev\", \"path\": {\"secret/*\": {\"policy\": \"write\"}}}"}' \
https://ub22.thecodemountains.com/v1/sys/policy/dev



```
