resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
}


resource "google_compute_instance" "vm_instance" {
    name     	= "instance-scheduler"
    machine_type = "e2-small"

    boot_disk {
      initialize_params {
        image = "ubuntu-os-cloud/ubuntu-1804-lts"
      }
    }

    network_interface {
      network = google_compute_network.vpc_network.self_link
      access_config {

      }
    }
    tags                	= ["streamlit","web","ssh"]
    metadata_startup_script = file("./install_docker.sh")
}

resource "google_compute_firewall" "firewall" {
    name	= "terraform-firewall-allow-http"
    network = google_compute_network.vpc_network.self_link
    allow {
      protocol = "tcp"
      ports	= ["80", "8080"]
    }
    source_tags   = ["web"]
    source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-ssh" {
    name	= "terraform-firewall-allow-ssh"
    network = google_compute_network.vpc_network.self_link
    allow {
      protocol = "tcp"
      ports	= ["22"]
    }
    source_tags   = ["ssh"]
    target_tags = ["ssh"]
}

resource "google_compute_firewall" "streamlit" {
    name	= "terraform-firewall-streamlit"
    network = google_compute_network.vpc_network.self_link
    allow {
      protocol = "tcp"
      ports	= ["8501"]
    }
    source_tags   = ["streamlit"]
    target_tags = ["streamlit"]
}

resource "google_storage_bucket" "bucketinstances" {
    name      	= "terraformjlt_bkt_instance"
    location  	= "US"
    force_destroy = true
}

