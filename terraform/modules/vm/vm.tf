resource "azurerm_network_interface" "" {
  name                = "${var.name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip}"
  }
}

resource "azurerm_linux_virtual_machine" "" {
  name                = "${var.name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_DS2_v2"
  admin_username      = "${var.admin_username}"
  network_interface_ids = [azurerm_network_interface.test.id]
  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC72g7eOjfNUqvf/LDENfYbTTeo0NiiDVXo6pNxEPT0qi9BMTiFbvJK/rwtDOn4LpGa1WxVzSDQB78S39arQXSVwL4GDI4prnf5DlKVzcuYeGlwl/efxbJLwWaRRAkBZLMBJcgQyoc2JGwOGvNXYyH01OECFbtyTubqqM7Guq1u71U2A6AKP+ujtPUjXf5mIwtTP9R8bFIwUisxRUza0lNpSd5sQn3DQnDXTF9fLqPVpEheJixcmpHYVFh5KO2z+/+r/jYdVJ9Ws8wga6bwZT4bLFexcNkA5I0fl4ImPPiwAnBx0qC2WxfCdaJk/IbNysLsnXcp3W4uY6eDgUf0SjjY8DHcFQVZ/MUBh2+FCDFWKZ03AcOvafmZyDGV1YMxEfWx2TsoDUYBr5puYU0SRSZFCwSpX7yWYbO5yKdu4yEM+HNxsjn92FCcQj/VxFUaXMbLncnPPOm8v6lIa+ylr8qfYqUqfLtx8Fn8DmQ+Jpy6UdgZvLe0Czql3HDIECcKdzM= anave@DESKTOP-6HJMHT5"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
