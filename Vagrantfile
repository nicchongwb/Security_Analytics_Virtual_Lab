Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2104"
  
  config.vm.synced_folder ".", "/vagrant"
  
  # for other providers, cant be use on hyper-v
  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  config.vm.provision "shell",
  path: "init_mysql.sh"

  config.vm.provision "shell",
  path: "init_db.sh"

  config.vm.provision "shell",
  path: "init.sh"
end