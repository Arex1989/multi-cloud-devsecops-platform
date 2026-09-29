resource "azurerm_public_ip" "web" {
  name                = "pip-multicloud-dev-web"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_network_interface" "web" {
  name                = "nic-multicloud-dev-web"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "web-ipconfig"
    subnet_id                     = var.web_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web.id
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "web" {
  name                = "vm-multicloud-dev-web"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_D2nls_v6"
  admin_username      = "azureadmin"

  network_interface_ids = [
    azurerm_network_interface.web.id
  ]

  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureadmin"
    public_key = var.admin_ssh_public_key
  }

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  custom_data = base64encode(<<-CLOUDINIT
    #cloud-config
    package_update: true
    packages:
      - nginx

    runcmd:
      - systemctl enable nginx
      - systemctl start nginx
      - bash -c 'echo "<html><head><title>Multi-Cloud DevSecOps Platform</title></head><body><h1>Multi-Cloud DevSecOps Platform</h1><p>Azure Web Tier - Terraform managed</p><p>Nginx deployment completed automatically.</p></body></html>" > /var/www/html/index.html'
      - systemctl restart nginx
  CLOUDINIT
  )

  tags = var.tags
}
