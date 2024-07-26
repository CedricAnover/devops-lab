# Ad-hoc Commands

## Make
Using Make and Makefile just to make the lifecycle easier to manage.
```bash
# Deploy the infrastructure
make deploy

# Destroy the infrastructure
make destroy

# Test By Ping
make test
make test hosts=<ansible-group>

# Get Help
make help
```

## SSH
```bash
# Generate New SSH Key Pair
ssh-keygen -t rsa -b 4096 -f ./.ssh/id_rsa -C "admin@controller" -N ""

# Manual Provisioning of SSH Public Key to System Containers
ssh-copy-id -i '.ssh/id_rsa.pub' admin@$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' server-1)

# SSH to System Container
ssh admin@$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' server-1) -p 22
# When Sysbox Image is provisioned with SSH Public Key. Without Password Prompt.
ssh -i './.ssh/id_rsa' admin@$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' server-1) -p 22
```

## Docker
```bash
```

## Vagrant
```bash
# Deploy
vagrant up --no-parallel

# Destroy
vagrant destroy -f
```

## Ansible
```bash
# Test by Ping
ansible -i inventory.yml all -m ping

# Run a Playbook
ansible-playbook -i inventory.yml ./playbooks/localhost_controller/vagrant_up.yml
ansible-playbook -i inventory.yml ./playbooks/localhost_controller/vagrant_destroy.yml

# Run a Playbook (Verbose)
ansible-playbook -i inventory.yml -v ./playbooks/localhost_controller/vagrant_up.yml
ansible-playbook -i inventory.yml -v ./playbooks/localhost_controller/vagrant_destroy.yml

# Run Playbooks for Servers
ansible-playbook -i inventory.yml ./playbooks/servers/test_hello_world.yml
```

## Testing Docker Network - Static IP for System Containers
```bash
docker network create --subnet=172.18.0.0/16 devops-net

docker build -t server -f Dockerfile.server .

docker run --runtime=sysbox-runc \
    -it --rm \
    --hostname=test-host \
    -P --net devops-net --ip 172.18.0.5 \
    --name=test-container server

# Clean
docker image prune -f
docker network prune -f
```


## Task
The `task` command for `Taskfile.yml` (alternative to `Makefile` and `make`).
```bash
# See all commands
task --list
```
