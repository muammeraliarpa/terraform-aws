variable "aws_region" {
  description = "AWS bölgesi"
  default     = "eu-north-1"
}

variable "instance_type" {
  description = "EC2 instance tipi"
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH anahtar çifti adı"
  default     = "terraform-ssh-key"
}

variable "public_key" {
  description = "SSH public key content"
  type        = string
}
