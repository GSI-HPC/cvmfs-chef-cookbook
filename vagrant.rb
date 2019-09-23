Vagrant.configure(2) do |config|
  # install the Debian-provided Chef package
  config.vm.provision "shell", inline: <<-SHELL
     sudo apt-get -qq update
     sudo DEBIAN_FRONTEND=noninteractive apt-get -q -y install chef
  SHELL
end
