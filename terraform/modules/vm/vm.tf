resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}-ni"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip_address_id}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}-vm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_DS2_v2"
  admin_username      = "${var.vm_admin_username}"
  network_interface_ids = [azurerm_network_interface.test.id]
  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCYQbwQEY2ka+QWb7OQHowNLFYszmKd0xkuUbycRwp4hmPU0gvSZrA8mHL3+OCSssiway9cipsJ4iBGIpMOIntM0jS46a0tZINgtpd1ctcvJB1IbQU1cDNdpGPmMNwNaDP5xeuDwCTdJDRQB68lb5nKcIOErvW0mSBH/Q1KYoFfu5B5en44/4nMsE5MSyJfdT/zJKZDttC3prn+OL6CgbOtO5fWwdDwVcyCk8BXQP/YPsp59dLC79+qeaCJjls38KXByjR5E16sfMdtD0+MkIBEugbj7Jsxwz6UmgZG6FWGoh3aukAyYZ8rqOTLH7iLf+JZw+G6e/mIdNTqOQXhPXVpBB6X6gKkXn7rfZ/SK/t+RIpycZE1fWHYdaVqbyxaCDZ5VfGylDYchcDpE1ZJ9JmssXdPzMVPC7S/J7l4cqB7kIMVrTF3oTghJZb8rYT3vwUO9Cj7zMa/hhMJDnlkA8hiQx6JPVkTHiQM0eImahSw5rk0gBuP/ECkAsVNk4OC6BM= bharathivedurumudi@Bharathis-Air.attlocal.net"
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
