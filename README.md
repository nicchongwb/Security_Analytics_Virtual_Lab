# ICT3204

## Vagrant Environment

Vagrant Version: Vagrant 2.3.0

### 1. Web Server - Ubuntu v21.04

- linux kernel - 5.11

- installed with suiteCRM v7.10.35

## SuiteCRM

browse to `http://<IP-Address>/suitecrm/` and login with `Admin:Admin`

## Vagrant Prerequisite
### Install the following plugin before using docker_compose on Vagrant
```bash
vagrant plugin install vagrant-docker-compose
```

## start vagrant environment
```
vagrant up | vagrant up <name|id>
```

## ssh into machine
```
vagrant ssh | vagrant ssh <name|id>
```

## destroy vagrant environment
```
vagrant destroy
```

## reload vagrantfile | reload with provision
```
vagrant reload | vagrant reload --provision
```
