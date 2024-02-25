|Name|Status|
| ------------- | ------------- |
|FE-DEV|![example](https://github.com/cesxhin/FE-clock-in/actions/workflows/docker-image.yml/badge.svg?branch=develop)|
|FE-PROD|![example](https://github.com/cesxhin/FE-clock-in/actions/workflows/docker-image.yml/badge.svg?branch=main)|
|BE-DEV|![example](https://github.com/cesxhin/BE-clock-in/actions/workflows/docker-image.yml/badge.svg?branch=develop)|
|BE-PROD|![example](https://github.com/cesxhin/BE-clock-in/actions/workflows/docker-image.yml/badge.svg?branch=main)|

# ClockIn 🎫
### What'is?
Record the hours you put in for your tasks.

### Why should I use this service?
It's all automated, you just have to open the ticket and close when you've finished the activity and whenever you want you can export the data and hours spent.

## Management envs
### Globals
```
TZ=Europe/Rome
```
### Web🌐
```
NUXT_ENDPOINT_API=http://api:80
NUXT_PUBLIC_CLIENT_KEYCLOAK=client
NUXT_PUBLIC_SCOPE_KEYCLOAK=openid
NUXT_CLIENT_SECRET=
NUXT_ENDPOINT_KEYCLOAK=http://127.0.0.1:8080
NUXT_REALM_KEYCLOAK=client-realm
```
### Api🧮
```
DATABASE_CONNECTION="User ID=root;Password=toortoor!1234;Host=postgres;Port=5432;Database=clockin;"
LOG_LEVEL="Info"
ENDPOINT_KEYCLOAK=http://127.0.0.1:8080
REALM_KEYCLOAK=client-realm
```