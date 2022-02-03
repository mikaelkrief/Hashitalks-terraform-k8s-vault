
provider "vault" {
  # It is strongly recommended to configure this provider through the
  # environment variables described above, so that each user can have
  # separate credentials set in the environment.
  #
  # This will default to using $VAULT_ADDR
  # But can be set explicitly
  address         = "https://xxxxxxxxxxx:8200"
  skip_tls_verify = true

}

resource "vault_mount" "projet-a"{
  path = "secret/project-a"
  type = "kv-v2"
  description = "Secrets for Project A"
}

resource "vault_mount" "projet-b"{
  path = "secret/project-b"
  type = "kv-v2"
  description = "Secrets for Project B"
}


resource "vault_mount" "infra"{
  path = "secret/infrastructure"
  type = "kv-v2"
  description = "Secrets for infrastructure"
}


resource "vault_generic_secret" "example" {
  path = "${vault_mount.projet-a.path}/foo"

  data_json = <<EOT
{
  "foo":   "bar",
  "pizza": "cheese"
}
EOT
}
