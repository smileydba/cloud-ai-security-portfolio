package policies.encryption_at_rest
default allow = false
allow {
  input.resource.type == "storage"
  input.encrypted == true
}
