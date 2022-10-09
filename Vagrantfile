Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2104"
  
  config.vm.synced_folder ".", "/vagrant"
  
  # for other providers, cant be use on hyper-v
  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  config.vm.provision "docker" do |d|
    #attacker machine
    d.pull_images "kalilinux/kali-rolling"
    d.run "kali", image: "kalilinux/kali-rolling",
      cmd: "/bin/bash",
      args: "-ti"
  end
  
  config.vm.provision "shell",
  path: "init_mysql.sh"

  config.vm.provision "shell",
  path: "init_db.sh"

  config.vm.provision "shell",
  path: "init.sh"

  config.vm.provision "shell",
  path: "setup_filebeat.sh"
end