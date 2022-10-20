Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2104"
  
  #Configure Networking
  config.vm.network "public_network", ip: "192.168.1.201"
  
  #Configure the current project folder to be included
  config.vm.synced_folder ".", "/vagrant"
  
  #Configure network ports
  #suitecrm-server
  config.vm.network "forwarded_port", host: 80, guest: 80
  config.vm.network "forwarded_port", host: 9200, guest: 9200 # Elasticsearch (For HTTP)
  config.vm.network "forwarded_port", host: 9300, guest: 9300 # Elasticsearch (For transport)
  config.vm.network "forwarded_port", host: 5044, guest: 5044 # Logstash
  config.vm.network "forwarded_port", host: 5601, guest: 5601 # Kibana

  config.vm.provision "shell", path: "sysctl.sh", run: "always" #Change mmap counts to ensure virtual memory does not run out during installation
  
  # config.vm.provider "virtualbox" do |v|
  #   # v.gui = true
  #   v.name = "ICT3204"
  #   v.check_guest_additions = false
  #   v.memory = 4096
  #   v.cpus = 2
  # end
  
  # set up Docker in the new VM:
  config.vm.provision :docker
  
  config.vm.provision "shell", privileged: true, run: 'always',
  path: "setup.sh"

end
