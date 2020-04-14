data "template_file" "nginx" {
  template = "${file("files/templates/nginx/nginx.conf.tpl")}"
  vars = {
    port = "${var.WebPort}"
  }
}

data "template_file" "web" {
  template = "${file("files/static/webnode/example.js.tpl")}"
  vars = {
    port1 = "${var.DataBasePort}"
    username = "${var.UserDB}"
    password = "${var.PassDB}"
    host = "${aws_instance.app2.private_ip}"
    hostname = "localhost"
    port = 3000
  }
}