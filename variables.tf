variable "LOCATION" {
  default = "westeurope"
}

variable "VM_DISK" {
  default = "Standard_D2s_v3"
}

variable "PASSWORD" {
  type = string
}

variable "USER" {
  type = string
  default = "aiviadmin"
}

variable "VMNAME" {
  type = string
  default = "az104-07-vm0"
}
