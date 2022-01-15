# vpc resource
resource "google_compute_network" "final_vpc" {
  project                 = "mimetic-setup-319321"
  name                    = "final-vpc"
  auto_create_subnetworks = false
}

# Management subnet, includes nat-gateway and private VM 
resource "google_compute_subnetwork" "management" {
  name          = "management-subnet"
  ip_cidr_range = "10.1.10.0/24"
  region        = "europe-west1"
  network       = google_compute_network.final_vpc.id
}

# Restricted subnet, has a private standard GKE cluster
resource "google_compute_subnetwork" "restricted" {
  name          = "restricted-subnet"
  ip_cidr_range = "10.2.11.0/24"
  region        = "europe-west1"
  network       = google_compute_network.final_vpc.id
}

# Router and nat-gateway
resource "google_compute_router" "final_router" {
  name    = "final-router"
  region  = google_compute_subnetwork.management.region
  network = google_compute_network.final_vpc.id

  bgp {
    asn = 64514
  }
}
resource "google_compute_router_nat" "final_nat_gateway" {
  name                               = "final-router-nat"
  router                             = google_compute_router.final_router.name
  region                             = google_compute_router.final_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.management.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

resource "google_service_account" "instance_sarvice" {
  account_id   = "instance-service-account-id"
  display_name = "final_Service_Account"
}
resource "google_project_iam_binding" "final_project" {
  project = "mimetic-setup-319321"
  role    = "roles/container.admin"

  members = [
    "serviceAccount:${google_service_account.instance_sarvice.email}"
  ]
}

# private VM resource
resource "google_compute_instance" "managementinstance" {
  name         = "management-vm"
  machine_type = "e2-micro"
  zone         = "europe-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network    = google_compute_network.final_vpc.id
    subnetwork = google_compute_subnetwork.management.id
    network_ip =  "10.1.10.10"
  }
  # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
  #service_account = google_service_account.instance_sa.email
  #oauth_scopes    = [
  # "https://www.googleapis.com/auth/cloud-platform"
  #]
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.instance_sarvice.email
    scopes = ["cloud-platform"]
  }
}

# firewall role to allow access only through IAP
resource "google_compute_firewall" "default-fw" {
  name    = "test-firewall"
  network = google_compute_network.final_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "22" , "443"]
  }
  direction     = "INGRESS"
  source_ranges = ["35.235.240.0/20"]
}