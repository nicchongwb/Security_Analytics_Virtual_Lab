Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2104"
  
  #Configure Networking
  config.vm.network "public_network", ip: "192.168.1.201"
  
  #Configure the current project folder to be included
  config.vm.synced_folder ".", "/vagrant"
  
  #Configure network ports
  config.vm.network "forwarded_port", host: 8888, guest: 8888 # SuiteCRM
  config.vm.network "forwarded_port", host: 9200, guest: 9200 # Elasticsearch (For HTTP)
  config.vm.network "forwarded_port", host: 9300, guest: 9300 # Elasticsearch (For transport)
  config.vm.network "forwarded_port", host: 5044, guest: 5044 # Logstash
  config.vm.network "forwarded_port", host: 5601, guest: 5601 # Kibana
  
  config.vm.provision "docker" do |d|
    d.build_image "/vagrant/", args: "-t ubuntu-network -f /vagrant/Dockerfile.ubuntu-network"
    d.build_image "/vagrant/", args: "-t kali -f /vagrant/Dockerfile.kali"
    d.build_image "/vagrant/", args: "-t suitecrm-server -f /vagrant/Dockerfile.suitecrm-server"
    #Build ELK Stack Containers
    d.build_image "/vagrant/", args: "-t elasticsearch -f /vagrant/Dockerfile.elastic"
    d.build_image "/vagrant/", args: "-t logstash -f /vagrant/Dockerfile.logstash"
    d.build_image "/vagrant/", args: "-t kibana -f /vagrant/Dockerfile.kibana"
    d.build_image "/vagrant/", args: "-t heartbeat -f /vagrant/Dockerfile.heartbeat"
    d.build_image "/vagrant/", args: "-t metricbeat -f /vagrant/Dockerfile.metricbeat"
  end

  config.vm.provision :docker_compose, yml: "/vagrant/docker-compose.yaml", compose_version:"v2.10.0", run: "always"
  
  #Change mmap counts to ensure virtual memory does not run out during installation
  config.vm.provider "virtualbox" do |v|
    # v.gui = true
    v.name = "ICT3204"
    v.check_guest_additions = false
    v.memory = 4096
    v.cpus = 2
  end
  
  # set up Docker in the new VM:
  config.vm.provision "shell", path: "sysctl.sh", run: "always" 
  config.vm.provision "shell", privileged: true, run: 'always', path: "setup.sh"
  # config.vm.provision "shell", privileged: true, run: 'always', path: "router_logging.sh"

end
