storage "consul" {
        address = "127.0.0.1:8500"
        path = "vault/"
}
listener "tcp" {
        address = "0.0.0.0:443"
        tls_disable = 0
        tls_cert_file = "/etc/letsencrypt/live/ub22.thecodemountains.com/fullchain.pem"
        tls_key_file = "/etc/letsencrypt/live/ub22.thecodemountains.com/privkey.pem"
}
ui = true

