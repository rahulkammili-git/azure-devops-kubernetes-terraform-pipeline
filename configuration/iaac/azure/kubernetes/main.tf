provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.4.0"
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_group}_${var.environment}"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "terraform-k8s" {
  name                = "${var.cluster_name}_${var.environment}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = var.dns_prefix

  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC2Ppo6WG7HXQFlvkgG3XRTz9BW34PNid/jNbVwYy57Z5Cs+nGuun21VizgXJCa57Q+tmj8iDI3NyQPgPdH5SiJ2W5GIR2iPnWvSCw/sigigMgzNxNr7/3bSL7t7kg9l8DuqM70nkBbrIWO52Bx9UrtVO3HL4voe9oeXOxPLhjJJgC6V6fn+24NDyk4XZuAYYfu7btPB1RQzxG57rQvZ6k82Q6HLXiB5ms+PF0ZmS/aql4W5pqKgHc7lJKei6FV52ymPKza+JyXW6PZOfgEFWPhUOUy278iHGFHJ2ap/Cur/KAFoxAJB8Ob7zldOsgkG+ED3tiqsRyJ6CC6R+H3gLF2okVI5qllBsxqOhVPgH7Kc3TFAu92tqrfQJRPMA8s/bfaamoYLm750g21gp3zfMx55rcLbweSBmXameNEFYqxplKeIZKuFgxFVevkEG04/dfo1EjIegqJxoIprcwhmaWp7rMqEJgZEDxYaJDz+REDfT2nFZFPVV3ej0EnO1eOxWs= generated-by-azure"
    }
  }

  default_node_pool {
    name            = "agentpool"
    node_count      = var.node_count
    vm_size         = "Standard_DS1_v2"
  }

  service_principal {
    client_id     = "c4e889ba-e58e-4701-97c0-3313c159b866"
    client_secret = "M-1Gpo0ygy8_p_IOZ_5gQ1M-Kk12gYtkW0"
  }

  tags = {
    Environment = var.environment
  }
}

