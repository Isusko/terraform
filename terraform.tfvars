 virginia_cidr = "10.10.0.0/16"
/*public_subnet = "10.10.0.0/24"
private_subnet = "10.10.1.0/24" */


subnets = ["10.10.0.0/24","10.10.1.0/24"]

tags = {
  "env" = "dev"
  "owner" = "Suko"
  "cloud" = "AWS"
  "IAC" ="Terraform"
  "IAC_Version" = "1.4.2"
  "project" ="cerberus"
  "region" = "virginia"
}

sg_ingress_cidr = "0.0.0.0/0" ##al poner 0::0/0 se indica que desde cualquier red nos podemos conectar
##pero para sar más especifico tenemos que poner la IP de nuestra área de trabajo o nuestra casa. 

ec2_specs = {
  "ami" = "ami-00c39f71452c08778"
  "instance_type" = "t2.micro"
}
enable_monitoring = 0

ingress_ports_list = [ 22,80,443 ]


