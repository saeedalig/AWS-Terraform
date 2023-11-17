# Create a Null Resource and Provisioners
resource "null_resource" "copy_keypair" {
  depends_on = [aws_instance.bastion_host]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type     = "ssh"
    host     = aws_eip.eip-bastion.public_ip 
    user     = "ec2-user"
    password = ""
    private_key = file("${path.module}/keys/tf-mum.pem")
  } 

  ## File Provisioner: Copy the tf-mum.pem file to /tmp/tf-mum.pem
  provisioner "file" {
    source      = "keys/tf-mum.pem"
    destination = "/tmp/tf-mum.pem"
  }
## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/tf-mum.pem"
    ]
  }
## Local Exec Provisioner:  local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  provisioner "local-exec" {
    command = "echo VPC created on `date` and VPC ID: ${var.vpc_id} >> creation-time-vpc-id.txt"
    working_dir = "local-exec-output-files/"
    #on_failure = continue
  }
}