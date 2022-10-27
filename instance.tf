module "myjavaserver" {
  source        = "./modules/javaserver"
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name
  key           = file("${path.module}/id_rsa.pub")
}