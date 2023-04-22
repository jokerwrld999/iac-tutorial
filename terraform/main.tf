resource "google_compute_instance" "raddit" {
    name = "raddit-instance"
    machine_type = "n1-standard-1"
    zone = "europe-west1-b"

    # boot disck specifications
    boot_disk {
      initialize_params {
        image = "raddit-base"
      }
    }

    # newtorks to attach to the VM
    network_interface {
      network = "default"
      access_config {} // use ephemeral public IP
    }
  
}