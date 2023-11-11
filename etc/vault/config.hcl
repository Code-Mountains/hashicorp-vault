storage "consul" {
        address = "127.0.0.1:8081"
        path = "vault/"
}
listener "tcp" {
        address = "127.0.0.1:8443"
        tls_disable = 0
        tls_cert_file = "/etc/letsencrypt/live/vault.thecodemountains.com/fullchain.pem"
        tls_key_file = "/etc/letsencrypt/live/vault.thecodemountains.com/privkey.pem"
}
ui = true

