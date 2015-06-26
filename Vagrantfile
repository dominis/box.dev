VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian-jessie-8.0-RC2"
  config.vm.box_url = "http://static.gender-api.com/debian-8-jessie-rc2-x64-slim.box"

  config.ssh.forward_agent = true

  config.vm.define "dev" do |devconf|
    devconf.vm.hostname = "box.dev"

    devconf.vm.network "forwarded_port", guest: 3306 ,host: 3306
    devconf.vm.network "forwarded_port", guest: 6379 ,host: 6379

    devconf.vm.synced_folder "../", "/home/vagrant/src"
    devconf.vm.synced_folder "./puppet", "/tmp/puppet"

    devconf.vm.provision "shell", inline: "apt-get install -y git netselect-apt"
    devconf.vm.provision "shell", inline: "cd /etc/apt; netselect-apt > /dev/null 2>&1"
    devconf.vm.provision "shell", inline: "apt-get update; apt-get dist-upgrade -y"
    devconf.vm.provision "shell", inline: "gem install librarian-puppet"
    devconf.vm.provision "shell", inline: "cd /tmp/puppet && librarian-puppet install"

    devconf.vm.provision :puppet do |p|
       p.manifests_path = "./puppet"
       p.manifest_file  = "devbox.pp"
       p.options = ["--hiera_config /tmp/puppet/manifests/hiera.yml", "--modulepath=/tmp/puppet/modules"]
    end
  end

end
