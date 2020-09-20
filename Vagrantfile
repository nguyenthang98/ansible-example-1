NODE_COUNT = 3
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  (1..NODE_COUNT).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.network "private_network", ip: "192.168.100.1#{i}"
      node.vm.hostname = "node-#{i}"
      node.vm.provider :virtualbox do |vb, override|
        vb.memory = "1024"
        vb.cpus = "2"
      end
			node.vm.provision "shell", path: "scripts/docker-compose.sh", run: "always"
    end
  end
  config.vm.define "ansible-client" do |node|
    node.vm.network "private_network", ip: "192.168.100.5"
    node.vm.synced_folder "playbook/", "/var/playbook", mount_options: ["dmode=755,fmode=755"]
    node.vm.hostname = "ansible-client"
      node.vm.provider :virtualbox do |vb, override|
        vb.memory = "512"
        vb.cpus = "1"
      end
  end
  config.vm.provision "shell", path: "scripts/docker.sh"
  config.vm.provision "shell", inline: <<-SHELL
     # enable ntp
     sudo timedatectl set-timezone Asia/Ho_Chi_Minh
     sudo timedatectl set-ntp true
     # enable ssh password authentication
     sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config    
     systemctl restart sshd.service
  SHELL
end
