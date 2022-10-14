Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  
  config.vm.synced_folder ".", "/vagrant"
  
  # for other providers, cant be use on hyper-v
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 9200, host: 9200 # Elastic HTTP
  config.vm.network "forwarded_port", guest: 9300, host: 9300 # Elastic TCP 
  config.vm.network "forwarded_port", guest: 5601, host: 5601 # Kibana
  config.vm.network "forwarded_port", guest: 80 host: 8080 # SuiteCRM

  config.vm.provider "virtualbox" do |v|
    v.gui = true
    v.name = "ICT3204"
    v.check_guest_additions = false
    v.memory = 4096
    v.cpus = 2
  end

  # set up Docker in the new VM:
  config.vm.provision :docker
  
  # Run shell script to setup VM
  $COMMANDS = <<-'SCRIPT'
  cd /vagrant/router_setup/
  chmod +x setup.sh
  # ./setup.sh
  SCRIPT

  config.vm.provision "shell", inline: $COMMANDS, privileged: true, run: 'always'
end