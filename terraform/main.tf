resource "google_compute_instance" "raddit" {
    name = "raddit-instance"
    machine_type = "n1-standard-1"
    zone = "europe-west1-b"

    # boot disck specifications
    boot_disk {
      initialize_params {
        image = "ubuntu-2004-lts"
      }
    }

    # newtorks to attach to the VM
    network_interface {
      network = "default"
      access_config {} // use ephemeral public IP
    }
}

resource "google_compute_project_metadata" "raddit" {
  metadata =  {
    ssh-keys = "raddit:${file("~/.ssh/raddit.pub")}" // path to ssh key file
  }
}

resource "google_compute_firewall" "raddit" {
  name    = "allow-raddit-tcp-9292"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
}