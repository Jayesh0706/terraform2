resource "local_file" "new"{
    content = "my new file using tf"
    filename = "new.txt"
}

resource "local_sensitive_file" "sensetive_file" {
  filename = "${path.module}/sensetive.txt"
  content = "mypassword"
}