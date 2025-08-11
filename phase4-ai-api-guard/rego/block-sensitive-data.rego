package ai.guard
deny[msg] {
  some k
  input.prompt[k]
  re_match("(?i)(ssn|passport|credit card)", input.prompt[k])
  msg := "PII detected in prompt"
}
