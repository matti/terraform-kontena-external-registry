resource "null_resource" "start" {
  provisioner "local-exec" {
    command = "echo depends_id=${var.depends_id}"
  }
}

locals {
  hostname = "${element(split("://", var.url), 1)}"
}

resource "null_resource" "kontena_external_registry" {
  depends_on = ["null_resource.start"]

  provisioner "local-exec" {
    command = <<EOF
kontena external-registry add \
-u ${var.username} \
-e ${var.email} \
-p \"${var.password}\" \
${var.url}
EOF
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "kontena external-registry rm --force ${local.hostname}"
  }
}
